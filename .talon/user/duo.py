from talon.voice import Word, Key, Context, Rep, Str, press
import time

duomap = {}

mapping = {
    'semicolon': ';',
    r'new-line': '\n',
    r'new-paragraph': '\n\n',
}

def parse_word(word):
    word = word.lstrip('\\').split('\\', 1)[0]
    word = mapping.get(word, word)
    return word

def text(m):
    tmp = [str(s).lower() for s in m.dgndictation[0]._words]
    words = [parse_word(word) for word in tmp]
    Str(' '.join(words))(None)

def navigate(m):
    Key('cmd-alt-right')(None)
    time.sleep(0.1)
    Key('cmd-a')(None)
    time.sleep(0.1)
    Key('delete')(None)
    time.sleep(4)
    Key('cmd-left alt-right right cmd-backspace')(None)
    time.sleep(0.1)
    Key('cmd-shift-right')(None)
    time.sleep(0.1)
    Key('cmd-c')(None) # remove 'deutsch', copy everything
    time.sleep(0.1)
    Key('cmd-alt-left')(None)
    time.sleep(0.1) # give some time for chrome to switch browsers
    Key('cmd-right cmd-v')(None) # append to current text

ctx = Context('duo', func=lambda app, win: any(s in win.title for s in ('Duolingo', 'SpeechTexter')))

duomap.update({
    'english <dgndictation> [over]': text,
    "say <dgndictation>": [Key('cmd-a'), lambda m: time.sleep(0.1), Key('backspace'), text],
    'deutsch <dgndictation> [over]': navigate,
    'veeder <dgndictation> [over]': [Key('cmd-a'), lambda m: time.sleep(1.1), Key('backspace'), navigate],
    "slaw": Key('enter'),
    })

ctx.keymap(duomap)

