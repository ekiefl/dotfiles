from talon.voice import Word, Key, Rep, Str, press
from .user_context import Context
from talon import ctrl
import string

def parse_word(word):
    word = word.lstrip('\\').split('\\', 1)[0]
    word = mapping.get(word, word)
    return word

def text(m):
    tmp = [str(s).lower() for s in m.dgndictation[0]._words]
    words = [parse_word(word) for word in tmp]
    Str(' '.join(words))(None)

ctx = Context('python', bundle='com.googlecode.iterm2', func=lambda app, win: any(s in win.title for s in ('.py', 'IPython', 'Snakefile', '.ipynb', 'anvi-')))

pythonmap = {}


basicpython  = {
    'she bang'     : '#!/usr/bin/env python\n# -*- coding: utf-8',
    'def'          : 'def ',
    'loop'         : 'for ',
    'class'        : 'class ',
    'return'       : 'return ',
    "from"         : "from ",
    "with"         : "with ",
    "lint"         : " in ",
    "not lint"     : " not in ",
    "andy"         : " and ",
    "andy not"     : " and not ",
    "ordy"         : " or ",
    "ordy not"     : " or not ",
    "sass"         : " as ",
    "lambda"         : "lambda ",
    "range"        : ["range()", Key("left")],
    "dickt"        : ["dict()", Key("left")],
    "list"        : ["list()", Key("left")],
    "set"        : ["set()", Key("left")],
    "tupple"       : ["tuple()", Key("left")],
    "zilch"        : ["zip()", Key("left")],
    'print'        : ["print()", Key("left")],
    'type'        : ["type()", Key("left")],
    'enumerate'        : ["enumerate()", Key("left")],
    'open'         : ["open()", Key("left")],
    'sum'          : ["sum()", Key("left")],
    'len'          : ["len()", Key("left")],
    "is instance"  : ["isinstance()", Key("left")],
    "init"         : ["__init__()", Key("left")],
    "upend"        : ["append()", Key("left")],
    "vars"         : ["vars()", Key("left")],
    "dirk"          : ["dir()", Key("left")],
    "import"       : "import ",
    "sifty"         : " if ",
    "sifty not"         : " if not ",
    "sift"         : "if ",
    "sift not"     : "if not ",
    "else"         : "else",
    "elsey"         : " else ",
    "pass"         : "pass",
    "continue"         : "continue",
    "break"         : "break",
    "elif"         : "elif ",
    "try"          : ["try:", Key("enter"), Key("tab")],
    "except"       : "except",
    "finally"      : ["finally: ", Key("enter"), Key("tab")],
    "raise"        : "raise ",
    "true"         : "True",
    "false"        : "False",
    'none'         : "None",
    "self"         : "self",
    "iter"         : "iter",
    "dunder"       : "__",
    "dunder in it" : "__init__",
    "dunder main"  : "__main__",

    "integer"      : "int",
    "float"        : "float",
    "string"       : "str",

    "os"           : "os",
    "cyst argh"           : "sys.argv",
}; pythonmap.update(basicpython)


pandasmap = {
    "loke" : ["loc[]", Key("left")],
    "iloke" : ["iloc[]", Key("left")],
    "iter rose" : ["iterrows()"],
    "grouped by" : ["groupby()", Key("left")],
    "import pandas" : ["import pandas as pd"],
    "read csv" : ["pd.read_csv()", Key("left"), ", sep='\\t'"] + [Key('left')]*10,
    "to csv" : ["to_csv()", Key("left"), ", sep='\\t', index=False"] + [Key('left')]*23,
}; pythonmap.update(pandasmap)

numpymap = {
    "numb pie" : ["numpy"],
    "import numb pie" : ["import numpy as np"],
    "lin space" : ["linspace()", Key("left")],
}; pythonmap.update(numpymap)

matplotlibmap = {
    "import matplotlib" : ["import matplotlib.pyplot as plt"],
}; pythonmap.update(matplotlibmap)

argparse = {
    "arrgh parse" : ["argparse"],
    "arrgh parse template" : """ap = argparse.ArgumentParser()\nap.add_argument('--full-name', '-m', default=None, help='brief description')\nargs = ap.parse_args()""",
}; pythonmap.update(argparse)


ctx.keymap(pythonmap)


