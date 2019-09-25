from .user_context import Context
from talon_plugins import eye_mouse

ctx = Context('eye_control')
ctx.keymap({
    'debug overlay':   lambda m: eye_mouse.debug_overlay.toggle(),
    'mouser':   lambda m: eye_mouse.control_mouse.toggle(),
    'camera overlay':  lambda m: eye_mouse.camera_overlay.toggle(),
    'run calibration': lambda m: eye_mouse.calib_start(),
})

