import time
from talon import ui
from .speech_toggle import enable_talon_speech, disable_talon_speech, enable_dragon_speech, disable_dragon_speech

# these apps have preferential modes that are set before focusing to them and after leaving them
special_apps = {
    'Microsoft Word': {
        'enter': [enable_talon_speech, disable_dragon_speech],
        'exit': []
    },
    'Microsoft Excel': {
        'enter': [enable_talon_speech, disable_dragon_speech],
        'exit': []
    },
    'TextEdit': {
        'enter': [enable_talon_speech, enable_dragon_speech],
        'exit': [disable_dragon_speech]
    },
}

def on_activate(app):
    print('{0.name} is activated'.format(app))
    if app.name in special_apps:
        for action in special_apps[app.name]['enter']: action(None)

def on_deactivate(app):
    print('{0.name} is deactivated'.format(app))
    if app.name in special_apps:
        for action in special_apps[app.name]['exit']: action(None)

ui.register('app_deactivate', on_deactivate)
ui.register('app_activate', on_activate)
