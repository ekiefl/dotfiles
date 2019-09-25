from talon.voice import Word, Key, Rep, Str, press
from .user_context import Context
import time
ctx = Context('chrome', bundle='com.google.Chrome')

from .vim import common_to_bash

chromemap = {}

chromemap.update(common_to_bash)

chromemap.update({'%d ruff' % k: [Key('J')]*k for k in range(1, 10)})
chromemap.update({'%d buff' % k: [Key('K')]*k for k in range(1, 10)})


chromemap.update({
    "go to amazon" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "amazon.com", Key("enter")],
    "go to calendar" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "calendar.google.com", Key("enter")],
    "go to wikipedia" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "wikipedia.com", Key("enter")],
    "go to github" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "github.com", Key("enter")],
    "go to facebook" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "facebook.com", Key("enter")],
    "go to gmail" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "gmail.com", Key("enter")],
    "go to google" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "google.com", Key("enter")],
    "go to read it" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "reddit.com", Key("enter")],
    "go to drive" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "drive.google.com", Key("enter")],
    "go to netflix" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "netflix.com", Key("enter")],
    "go to lab fiesta" : [Key("escape escape cmd-l"), lambda m: time.sleep(0.1), "https://github.com/merenlab/lab-fiesta", Key("enter")],
    "set up duo": [Key("cmd-n"), Key("cmd-l"), "duolingo.com", Key("enter"), Key("cmd-t"), "speechtexter.com", Key("enter"), lambda m: time.sleep(2), "f", lambda m: time.sleep(1), "w"],
    })

chromemap.update({
    'more' : 'd',
    'less' : 'u',
    'box' : '',
    'lesser' : Key('alt-up'),
    'mortar' : Key('alt-down'),
    'out' : [Key('tab')]*25,
    'dark mode' : Key('alt-shift-d'),
    'zoom in' : Key('cmd-='),
    'zoom out' : Key('cmd+-'),
    'pan left' : 'h'*4,
    'pan right' : 'l'*4,
    'nex' : 'n',
    'bex' : 'N',
    'tab search' : 'T',
    'ruff' : Key("escape J"),
    'buff' : Key("escape K"),
    'refresh' : 'cmd-r',
    })

chromemap.update({
    "feedblock": ['<span style="color:red">FEEDBACK: </span>', Key('left left left left left left left')],
})

ctx.keymap(chromemap)

