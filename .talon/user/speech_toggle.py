
from talon.voice import Context, ContextGroup

from talon.engine import engine
from talon_plugins import speech

sleep_group = ContextGroup('sleepy')
sleepy = Context('sleepy', group=sleep_group)

enable_talon_speech = lambda m: speech.set_enabled(True)
disable_talon_speech = lambda m: speech.set_enabled(False)
enable_dragon_speech = lambda m: engine.mimic('wake up'.split())
disable_dragon_speech = lambda m: engine.mimic('go to sleep'.split())

sleepy.keymap({
    'talon sleep': disable_talon_speech,
    'talon wake': enable_talon_speech,

    'dragon mode': [disable_talon_speech, enable_dragon_speech],
    'talon mode': [enable_talon_speech, disable_dragon_speech],
})
sleep_group.load()
