from talon.voice import Key, Str, press
from .user_context import Context
from talon import clip

ctx = Context('clipboard')

def get_selection():
    with clip.capture() as s:
        press('cmd-c', wait=0)
    return s.get()

def apply_to_line(fn):
    def wrap(m):
        press('shift-alt-left')
        sel = get_selection()
        Str(fn(sel))(None)
    return wrap

ctx.keymap({
    'run caps': apply_to_line(lambda s: s.capitalize()),
    'run yeller': apply_to_line(lambda s: s.upper()),
})
