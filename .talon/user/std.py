from talon.voice import Word, Key, Rep, Str, press
from .user_context import Context
import copy
from talon import ctrl
import string

ctx = Context('input')

alpha_alt = 'air bat cap die each fail gone harm sit jury crash look mad near odd pit quest red sun trap urge vest whale box yes zip'.split()
alnum = list(zip(alpha_alt, string.ascii_lowercase)) + [(str(i), str(i)) for i in range(0, 10)]

alpha = {}
alpha.update(dict(alnum))
alpha.update({'ship %s' % word: letter for word, letter in zip(alpha_alt, string.ascii_uppercase)})

# for bash.py
lower_upper_digits = copy.deepcopy(alpha)

punctuation = {
    'question': '?',
    'eek': '=',
    'dash': '-',
    'plus': '+',
    'tilde': '~',
    'bang': '!',
    'doll': '$',
    'downer': '_',
    'semi': ';',
    'colon': ':',
    'lack': '[',
    'brack': ']',
    'larry': '(',
    'party': ')',
    'lace': '{',
    'brace': '}',
    'langle': '<',
    'rangle': '>',
    'star': '*',
    'hash': '#',
    'mod': '%',
    'flex': '^',
    'ash': '@',
    'amper': '&',
    'pipe': '|',
    'quote': '"',
    'tick': '`',
    'sote': "'",
    'dock': '.',
    'conner': ',',
    'space': ' ',
    'slash': '/',
    'halls': '\\',
}

alpha.update({'corey %s' % k: Key('ctrl-%s' % v) for k, v in alnum})
alpha.update({'commy %s' % k: Key('cmd-%s' % v) for k, v in alnum})
alpha.update({'commy ship %s' % k: Key('cmd-shift-%s' % v) for k, v in alnum})
alpha.update({'alt %s' % k: Key('alt-%s' % v) for k, v in alnum})

word_for_enter = 'slaw'
# enter with modifiers
alpha.update({'corey %s' % word_for_enter:  Key('ctrl-enter'),
              'commy %s' % word_for_enter:  Key('cmd-enter'),
              'ship %s' % word_for_enter:  Key('shift-enter'),
              'commy ship %s' % word_for_enter:  Key('cmd-shift-enter'),})


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

def word(m):
    tmp = [str(s).lower() for s in m.dgnwords[0]._words]
    words = [parse_word(word) for word in tmp]
    Str(' '.join(words))(None)

def surround(by):
    def func(i, word, last):
        if i == 0: word = by + word
        if last: word += by
        return word
    return func

def rot13(i, word, _):
    out = ''
    for c in word.lower():
        if c in string.ascii_lowercase:
            c = chr((((ord(c) - ord('a')) + 13) % 26) + ord('a'))
        out += c
    return out

def vak(i, word, _):
    if i == 0:
        return ' --'+word
    else:
        return '-'+word

formatters = {
    'dunder':       (True,  lambda i, word, _: '__%s__' % word if i == 0 else word),
    'camel':        (True,  lambda i, word, _: word if i == 0 else word.capitalize()),
    'snake':        (True,  lambda i, word, _: word if i == 0 else '_'+word),
    'dashword':     (True,  lambda i, word, _: word if i == 0 else '-'+word),
    'vak':          (True, vak),
    'dotword':      (True,  lambda i, word, _: word if i == 0 else '.'+word),
    'smash':        (True,  lambda i, word, _: word),
    'proper':       (True, lambda i, word, _: word.capitalize()),
    'title':        (False, lambda i, word, _: word.capitalize()),
    'yell':         (False, lambda i, word, _: word.upper()),
    'rot thirteen': (False, rot13),
}

def FormatText(m):
    fmt = []
    for w in m._words:
        if isinstance(w, Word):
            fmt.append(w.word)
    words = [str(s).lower() for s in m.dgndictation[0]._words]

    space_at_end = False

    tmp = []
    spaces = True
    for i, word in enumerate(words):
        word = parse_word(word)
        for name in reversed(fmt):
            if name == 'vak':
                space_at_end = True
            smash, func = formatters[name]
            word = func(i, word, i == len(words)-1)
            spaces = spaces and not smash
        tmp.append(word)
    words = tmp

    sep = ' '
    if not spaces:
        sep = ''
    string = sep.join(words)
    string += ' ' if space_at_end else ''
    Str(string)(None)

keymap = {}

# hacky ways for repeat commands that take numbers as variables
keymap.update({'%d work' % k: [Key('alt-backspace')]*k for k in range(2, 10)})
keymap.update({'%d chuck' % k: [Key('backspace')]*k for k in range(2, 10)})
keymap.update({'%d left' % k: [Key('left')]*k for k in range(2, 10)})
keymap.update({'%d right' % k: [Key('right')]*k for k in range(2, 10)})

keymap.update(alpha)
keymap.update(punctuation)


keymap.update({
    'say <dgndictation> [over]': text,
    'word <dgnwords>': word,
    '(%s)+ <dgndictation>' % (' | '.join(formatters)): FormatText,

    'corge': Key('ctrl-u'),

    'tap':   Key('tab'),
    'left':  Key('left'),
    'right': Key('right'),
    'up':    Key('up'),
    'down':  Key('down'),
    'fader':  Key('pagedown'),
    'ellie':  Key('pageup'),

    'zoom in' : Key('cmd-='),
    'zoom out' : Key('cmd+-'),

    "copy" : Key("cmd-c"),
    "paste" : Key("cmd-v"),
    "patirk" : [Key("cmd-v"), Key("enter")],

    'chuck': Key('backspace'),
    'work' : Key('alt-backspace'),

    word_for_enter: Key('enter'),
    'slaughter': [Key('cmd-right enter')],
    'skate': Key('esc'),

    # padded characters
    'eekert': ' = ',
    'dashert': ' - ',
    'plussert': ' + ',
    'semi-hurt': ' ; ',
    'coleinert': ' : ',
    'lackert': ' [ ',
    'brackert': ' ] ',
    'larryert': ' ( ',
    'partiert': ' ) ',
    'lacert': ' { ',
    'bracert': ' } ',
    'langlert': ' < ',
    'ranglert': ' > ',
    'startert': ' * ',
    'hashert': ' # ',
    'modert': ' % ',
    'ampert': ' & ',
    'pipert': ' | ',
    'dockert': ' . ',
    'connert': ' , ',
    'spacert': '   ',
    'slashert': ' / ',
    'backslash': '\\',

    'deek' : '==', # double eek
    'sneak' : '!=', # 'snot double eek
    'langdeek' : '<=', # langle deek
    'rangdeek' : '>=', # rangle deek
    'deekert' : ' == ',
    'sneakert' : ' != ',
    'langdeekert' : ' <= ',
    'rangdeekert' : ' >= ',
    'lankert' : ' <- ',

    'spamma': ', ',
    'hasha': '# ',
    'call' : "()",
    'empty square': '[]',
    'empty dish': '{}',
    'empty dime': '<>',

    'triple tap': Key("tab tab tab"),
    'triple quote': '"""',
    'triple sote': "'''",
    'triple backtick': "```",

    'square' : ['[]', Key("left")],
    'dish': ['{}', Key('left')],
    'dime': ['<>', Key('left')],

    'to do': '- [ ] ',

    'next window': Key('cmd-`'),
    'last window': Key('cmd-shift-`'),
    'spotlight' : Key('cmd-space'),
    'last': Key('cmd-tab'),

    # a bunch of common names that i use
    "been" : "bin",
    "doc pie": ".py",
    "jean" : "gene",
    "vim our see" : "~/.vimrc",
    "bash profile" : "~/.bash_profile",
    "bash are sea" : "~/.bashrc",
    "bash aliases" : "~/.bash_aliases",
    "asdf" : "asdf",
    "html" : "html" ,
    "zotero" : "zotero",
    "eye-term" : "iterm",
    "chrome" : "chrome",
    "slack" : "slack",
    "dragon" : "dragon",
    "textedit" : "textedit",
    "github" : "github",
    'anvio' : 'anvio',
    'anvi' : 'anvi-',
    "utils" : "utils",
    "keyfull" : "kiefl",
    "my e-mail" : "kiefl.evan@gmail.com",

    # some multi-stroke commands
    "code block" : ["```", Key('enter'), "```", Key('up'), Key('enter')],

})

ctx.keymap(keymap)
