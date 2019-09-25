from collections import defaultdict
import json
import math
import os
import queue
import subprocess
import threading
import time

from talon import ctrl, eye, screen, tap, ui
from talon.api import ffi, lib
from talon.engine import engine
from talon.track.filter import MultiFilter, OneEuroFilter, Acceleration
from talon.track.geom import Point2d, Point3d, EyeFrame
from talon_init import TALON_HOME

main_screen = ui.main_screen()

#### user configuration ####
class config:
    size_mm = Point2d(main_screen.mm_x, main_screen.mm_y)
    offx_mm = 0
    size_px = Point2d(main_screen.width, main_screen.height)
    ### Other config ###
    velocity = Point2d(150, 225)

    show_overlay = False
    control_mouse = False

    # Acceleration and filter configs
    acceleration = Acceleration.default
    one_euro_filter = OneEuroFilter.default
#### end config

from eye import tracker

class EyeMouse:
    def __init__(self):
        self.eye_hist = []
        self.xy_hist = []
        self.last_time = None
        self.filt = MultiFilter(OneEuroFilter, 2, **config.one_euro_filter)
        self.jump_filt = MultiFilter(OneEuroFilter, 2, **config.one_euro_filter)
        self.origin = None
        self.frame = 0
        self.accel = Acceleration(**config.acceleration)

        self.mbuttons_down = set()
        self.last_click = 0
        self.img = None
        self.img_handle = None

        self.zone1 = self.zone2 = None

    def on_click(self, typ, event):
        if event.flags & tap.DOWN:
            self.mbuttons_down.add(event.button)
            self.last_click = time.time()
        elif event.flags & tap.UP:
            if event.button in self.mbuttons_down:
                self.mbuttons_down.remove(event.button)

    def on_stream(self, topic, b):
        cmd = b['cmd']
        if cmd != eye.SUB_GAZE:
            return

        self.frame += 1
        l, r = EyeFrame(b, 'Left'), EyeFrame(b, 'Right')
        ts = time.time()

        # crossed eyes seem more accurate:
        # TODO factor in eye position relative to sensor: ideal is eye looking across the sensor
        weight = lambda x: max(0.25, min((0.25 + (max(x, 0) ** 1.8) / 2), 0.75))
        lw = weight(l.gaze.x)
        rw = 1 - weight(r.gaze.x)
        pos = (l.gaze * lw + r.gaze * rw) / (lw + rw)

        if r and not l: pos = r.gaze.copy()
        elif l and not r: pos = l.gaze.copy()
        pos.frame = self.frame
        pos *= config.size_px
        pos.x = min(max(pos.x, 35), config.size_px.x - 35)
        pos.y = min(max(pos.y, 35), config.size_px.y - 35)

        if not self.origin:
            self.origin = pos
        if self.xy_hist and not (l or r):
            pos = self.xy_hist[-1]

        delta = Point2d(0, 0)
        if self.eye_hist and self.xy_hist:
            now = time.time()
            dt = 1 if self.last_time is None else now - self.last_time
            self.last_time = now

            ll, lr = self.eye_hist[-1]
            ldelt = (l.rel - ll.rel) / 2
            rdelt = (r.rel - lr.rel) / 2
            out = []
            deltas = ldelt, rdelt
            if not r or not lr: deltas = ldelt,
            if not l or not ll: deltas = rdelt,
            for delt in deltas:
                out.append(Point2d(-delt.x, delt.y))

            delt = out[0]
            for o in out[1:]:
                delt += o
            delt /= len(out)

            delt = delt.apply(self.filt, dt)
            delt *= config.velocity
            delt = delt.apply(self.accel, dt)

            # stabilize head movement immediately after a click to prevent accidental click+drag
            if self.mbuttons_down and time.time() - self.last_click <= 0.25:
                if abs(delt.x) < 10 and abs(delt.y) < 10:
                    delt.x = delt.y = 0

            lastpos = self.xy_hist[-1]
            travel = (lastpos - self.origin).len()
            frames = pos.frame - self.origin.frame
            # TODO: vary zone size on dynamic eye jitter and common eye offset from desired target
            # TODO: make zone size configurable
            # TODO: use physical size + user distance for zone size
            # which I guess is just a proxy for "eye tracker resolution"
            # perhaps can compute this from a "dead zone sensitivity" multiplier
            #zone1 = 180 * min((frames / 60.0) ** 2, 1)
            zone1 = 90 * min((frames / 60.0) ** 2, 1)
            zone2 = (math.log(max(travel, zone1 / 4) + 20) * 18)

            # center2 = lastpos + (pos - lastpos) / 2
            center2 = lastpos
            self.zone1 = (pos, self.origin, zone1)
            self.zone2 = (pos, center2, zone2)
            exit1 = (pos - self.origin).len() > zone1
            exit2 = (pos - center2).len() > zone2
            if exit1 and exit2:
                self.origin = pos
            elif frames < 6 and not exit2:
                pos.apply(self.jump_filt, dt)
                pos.frame = self.origin.frame
                self.origin = pos
            else:
                pos = lastpos + delt

            delta = pos - lastpos

        self.eye_hist.append((l, r))
        pos.ts = ts
        self.xy_hist.append(pos)
        self.eye_hist = self.eye_hist[-90 * 10:]
        self.xy_hist = self.xy_hist[-90 * 10:]

        x = min(max(0, pos.x), config.size_px.x)
        y = min(max(0, pos.y), config.size_px.y)
        if config.control_mouse:
            ctrl.mouse(x, y, delta.x, delta.y)

mouse = EyeMouse()

def eye_artist(vg, width, height):
    if len(mouse.xy_hist) < 3:
        return

    lib.nvgStrokeWidth(vg, 2)
    z1, z2 = mouse.zone1, mouse.zone2
    if z1 and z2:
        lib.nvgStrokeColor(vg, lib.nvgRGBA(0, 255, 0, 255))
        pos, origin, radius = z1
        lib.nvgBeginPath(vg)
        lib.nvgCircle(vg, origin.x, origin.y, radius)
        lib.nvgMoveTo(vg, origin.x, origin.y)
        lib.nvgLineTo(vg, pos.x, pos.y)
        lib.nvgStroke(vg)

        lib.nvgStrokeColor(vg, lib.nvgRGBA(0, 255, 255, 255))
        pos, origin, radius = z2
        lib.nvgBeginPath(vg)
        lib.nvgCircle(vg, origin.x, origin.y, radius)
        lib.nvgMoveTo(vg, origin.x, origin.y)
        lib.nvgLineTo(vg, pos.x, pos.y)
        lib.nvgStroke(vg)

        lib.nvgBeginPath(vg)
        lib.nvgStrokeColor(vg, lib.nvgRGBA(0, 0, 0, 255))
        lib.nvgCircle(vg, pos.x, pos.y, 5)
        lib.nvgStroke(vg)

    pos = mouse.xy_hist[-1]
    xyh = mouse.xy_hist
    last = xyh[0]
    for i, pos in enumerate(xyh[1:]):
        lib.nvgBeginPath(vg)
        lib.nvgMoveTo(vg, last.x, last.y)
        progress = i / (len(mouse.xy_hist)-1)
        lib.nvgStrokeColor(vg, lib.nvgRGBA(180, 0, 0, int(progress*255)))
        lib.nvgLineTo(vg, pos.x, pos.y)
        lib.nvgStroke(vg)
        last = pos

    for i, eyes in enumerate(mouse.eye_hist):
        color = lib.nvgRGBA(80, 0, 0, 80)
        for eye in eyes:
            pos = eye.gaze
            pos *= config.size_px
            lib.nvgBeginPath(vg)
            lib.nvgCircle(vg, pos.x, pos.y, 3)
            lib.nvgFillColor(vg, color)
            lib.nvgFill(vg)
            color = lib.nvgRGBA(0, 80, 0, 80)

tracker.register('', mouse.on_stream)
tap.register(tap.MCLICK, mouse.on_click)

def on_menu(item):
    if item == 'User Eye Mouse >> Show Debug Overlay':
        config.show_overlay = not config.show_overlay
        lib.menu_check(b'User Eye Mouse >> Show Debug Overlay', config.show_overlay)
        if config.show_overlay:
            app.register('overlay', eye_artist)
        else:
            app.unregister('overlay', eye_artist)
    elif item == 'User Eye Mouse >> Control Mouse':
        config.control_mouse = not config.control_mouse
        lib.menu_check(b'User Eye Mouse >> Control Mouse', config.control_mouse)

from talon import app
lib.menu_add(b'User Eye Mouse >> Control Mouse')
lib.menu_check(b'User Eye Mouse >> Show Debug Overlay', config.show_overlay)
lib.menu_check(b'User Eye Mouse >> Control Mouse', config.control_mouse)
app.register('menu', on_menu)
