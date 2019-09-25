from talon.engine import engine
import json

def listener(topic, m):
    if topic == 'cmd' and m['cmd']['cmd'] == 'g.load' and m['success'] == True:
        print('[grammar reloaded]')
    else:
        print(topic, m)

engine.register('', listener)
def unload(): engine.unregister('', listener)
