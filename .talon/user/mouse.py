import time
from talon import ctrl, tap
from talon.voice import Key, Context
from talon_plugins import eye_mouse
from talon_plugins.eye_mouse import Point2d

ctx = Context('mouse')
eye_mouse.config.velocity = 400
eye_mouse.config.acceleration = {'cd': (8, 65.0), 'v': (0.0004, 0.0025), 'lmb': 1000.0, 'ratio': 0.7}

x, y = ctrl.mouse_pos()
mouse_history = [(x, y, time.time())]
force_move = None

def on_move(typ, e):
    mouse_history.append((e.x, e.y, time.time()))
    if force_move:
        e.x, e.y = force_move
        return True
tap.register(tap.MMOVE, on_move)

def get_initial_mouse_pos(m):
    '''
    click where the mouse was at the start of the first word in the utterance
    '''
    word = m._words[0] # first word in utterance
    start = (word.start + min((word.end - word.start) / 2, 0.100)) / 1000.0 # add a little time
    diff, pos = min([(abs(start - pos[2]), pos) for pos in mouse_history])
    return pos[:2]

def get_final_mouse_pos(m):
    '''
    click  where the mouse was at the start of the last word in the utterance
    '''
    word = m._words[-1] # last word in utterance
    start = word.start / 1000.0 # feels more natural to timestamp the start of last word
    diff, pos = min([(abs(start - pos[2]), pos) for pos in mouse_history])
    return pos[:2]

def get_current_mouse_pos(m):
    return ctrl.mouse_pos()

def initial_pos_click(m, button=0, times=1, down=None, up=None):
    old = eye_mouse.config.control_mouse
    eye_mouse.config.control_mouse = False
    x, y = get_initial_mouse_pos(m)
    x_current, y_current = get_current_mouse_pos(m)
    ctrl.mouse_move(x, y)
    ctrl.mouse_click(pos=(x, y), button=button, down=down, up=up, times=times, wait=800)
    ctrl.mouse_move(x_current, y_current)
    time.sleep(0.032)
    eye_mouse.config.control_mouse = old
    eye_mouse.mouse.last_move = 0
    eye_mouse.mouse.last_ctrl = Point2d(x_current, y_current)

def final_pos_click(m, button=0, times=1, down=None, up=None):
    old = eye_mouse.config.control_mouse
    eye_mouse.config.control_mouse = False
    x, y = get_final_mouse_pos(m)
    x_current, y_current = get_current_mouse_pos(m)
    ctrl.mouse_move(x, y)
    ctrl.mouse_click(pos=(x, y), button=button, down=down, up=up, times=times, wait=800)
    ctrl.mouse_move(x_current, y_current)
    time.sleep(0.032)
    eye_mouse.config.control_mouse = old
    eye_mouse.mouse.last_move = 0
    eye_mouse.mouse.last_ctrl = Point2d(x_current, y_current)

def initial_pos_right_click(m):
    initial_pos_click(m, button=1)

def initial_pos_dubclick(m):
    initial_pos_click(m, button=0, times=2)

def initial_pos_tripclick(m):
    initial_pos_click(m, button=0, times=3)

def initial_pos_mouse_drag(m):
    initial_pos_click(m, button=0, times=1, down=True)

def initial_pos_dubmouse_drag(m):
    initial_pos_click(m, button=0)
    initial_pos_click(m, button=0, times=1, down=True)

def initial_pos_mouse_release(m):
    initial_pos_click(m, button=0, times=1, up=True)

def mouse_drag(m):
    x, y = get_initial_mouse_pos(m)
    ctrl.mouse_click(pos=(x, y), down=True)

def mouse_release(m):
    x, y = get_initial_mouse_pos(m)
    ctrl.mouse_click(pos=(x, y), up=True)

def advanced_click(button, click_func, *mods, **kwargs):
    '''
    Attach modifiers to mouse operations, which by default is pressed and released after the click
    function. If you want to hold modifier keys during a prolonged period between a mouse press and
    a mouse release, you should have 2 click functions. The down-click function is passed to
    advanced_click with the parameter hold_keys=True, and the corresponding up-click function is
    passed to advanced_click with the parameter release_all_keys=True.
    '''
    hold_keys = kwargs.get('hold_keys', False)
    release_all_keys = kwargs.get('release_all_keys', False)

    def click(e):
        for key in mods:
            ctrl.key_press(key, down=True)
        click_func(e)
        if not hold_keys:
            for key in mods[::-1]:
                ctrl.key_press(key, up=True)
        if release_all_keys:
            for key in ['ctrl', 'alt', 'shift', 'cmd', 'fn']:
                ctrl.key_press(key, up=True)

    return click

keymap = {
    'righty'          : initial_pos_right_click,
    'click'           : initial_pos_click,
    'clickirk'        : [initial_pos_click, Key('enter')],
    'rick'            : advanced_click(0, initial_pos_click, 'ctrl'),
    'drip'            : initial_pos_dubclick,
    'trick'           : initial_pos_tripclick,
    'press'           : initial_pos_mouse_drag,
    'dress'           : initial_pos_dubmouse_drag,
    'lease'           : advanced_click(0, initial_pos_mouse_release, release_all_keys=True),
    'leach'           : [advanced_click(0, initial_pos_mouse_release, release_all_keys=True), Key("backspace")],
    'lickop'          : [advanced_click(0, initial_pos_mouse_release, release_all_keys=True), Key("cmd-c")],

    "drickop"         : [initial_pos_dubclick, Key("cmd-c")],
    "trickop"         : [initial_pos_tripclick, Key("cmd-c")],

    'screencop'       : [Key('cmd-shift-ctrl-4'), initial_pos_mouse_drag],
    'screenshot'      : [Key('cmd-shift-4'), initial_pos_mouse_drag],

    'shift tap press' : advanced_click(0, initial_pos_mouse_drag, 'shift'),
    'shift press'     : advanced_click(0, initial_pos_mouse_drag, 'shift', hold_keys=True),
}

ctx.keymap(keymap)
