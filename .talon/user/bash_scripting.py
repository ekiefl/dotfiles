from talon.voice import Word, Key, Rep, Str, press
from .user_context import Context
ctx = Context('bash_scripting',
              bundle='com.googlecode.iterm2',
              func=lambda app, win: any(s in win.title for s in ('.sh', '.bash')))

bashmap_scripting = {}

syntax = {
    'sift': ['if ', Key('esc'), 'mz', 'a; then', Key('enter'), 'fi', Key('esc'), '\'za'],
    'loop': ['for ', Key('esc'), 'mz', 'a; do', Key('enter'), 'done', Key('esc'), '\'za'],
    'then': [Key('esc'), 'A', '; then', Key('enter tab')],
    'do': [Key('esc'), 'A', '; do', Key('enter tab')],
    'phi': 'fi',
    'done': 'done',

    'elif': 'elif',
    'else': 'else',
    'lint': ' in ',

    'ducker': ['[[ ]]', Key('left'), Key('left'), Key('left')],
    'bucker': ['[ ]', Key('left'), Key('left'), Key('left')],
}; bashmap_scripting.update(syntax)

ctx.keymap(bashmap_scripting)
