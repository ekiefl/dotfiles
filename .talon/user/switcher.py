import time

from talon import ui
from .speech_toggle import enable_talon_speech, disable_talon_speech, enable_dragon_speech, disable_dragon_speech

from talon.engine import engine
from talon_plugins import speech
from talon.voice import Context, Key
from collections import namedtuple

apps = {}

def switch_app(m, name=None, word_index=None, last=False):
    '''word_index determines which word in the phrase is the app name'''
    if not word_index and not name:
        raise Exception('If the app name is not supplied, a word index must be supplied')

    if word_index:
        name = str(m._words[word_index])

    full = apps.get(name)
    if not full:
        return

    for app in ui.apps():
        if app.name == full:
            app.focus()
            timestamp = time.time()
            while True:
                if ui.active_app().name == full:
                    break
                if time.time() - timestamp > 5:
                    raise Exception('{} could not be focused within five seconds. Giving up.'.format(full))
                time.sleep(0.03)
            break

ctx = Context('switcher')
keymap = {
    'termy':                      lambda m: switch_app(m, name='iTerm2'),
    'fox {switcher.apps}'       : lambda m: switch_app(m, word_index=1),
    'paste {switcher.apps}'     : [lambda m: switch_app(m, word_index=1), Key('cmd-v')],
    'paste all {switcher.apps}' : [Key('cmd-a cmd-x'), lambda m: switch_app(m, word_index=2), Key('cmd-v')],
    'google it'                 : [lambda m: switch_app(m, name='Chrome'), Key('cmd-t cmd-l cmd-v enter')]
}

ctx.keymap(keymap)

def update_lists():
    global apps
    new = {}
    for app in ui.apps():
        if app.background and not app.windows():
            continue
        words = app.name.split(' ')
        for word in words:
            if word and not word in new:
                new[word] = app.name
        new[app.name] = app.name
    if set(new.keys()) == set(apps.keys()):
        return
    ctx.set_list('apps', new.keys())
    apps = new

def ui_event(event, arg):
    update_lists()

ui.register('', ui_event)
update_lists()
