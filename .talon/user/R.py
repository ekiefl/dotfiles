from talon.voice import Word, Context, Key, Rep, Str, press
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

ctx = Context('R_programming', bundle='com.googlecode.iterm2', func=lambda app, win: '.R' in win.title)

Rmap = {}

basicR = {
    'library'      : ['library()', Key('left')],
    'options'     : ['options()', Key('left')],
    'she bang'    : [Key('escape'), 'mtggO', '#!/usr/bin/env Rscript', Key('escape'), '\'t'],
    'null'     : 'NULL',
    'true'     : 'TRUE',
    'false'     : 'FALSE',
    'read csv' : ["read.csv(, sep='\\t')"] +  [Key('left')] * 11,
    'print' : ["print()", Key('left')],
    'loop' : ["for ()", Key('left')],
    'lint' : [" in "],
    'sift' : ["if ()", Key('left')],
    'grepple' : ["grepl()", Key('left')],
    'split' : ["split()", Key('left')],
    'pastey' : ["paste()", Key('left')],
    'call names' : ['colnames()', Key('left')],
}; Rmap.update(basicR)

ggplot = {
    'jeejee plot'    : 'ggplot',
    'plot'           : ['plot()', Key('left')],
    'jeejee save'    : ["ggsave(, plot = last_plot(), width=NA, height=NA, units='cm', dpi=300)"] + [Key('left')] * 63,
    'add'            : [Key('escape'), 'A +', Key('enter')],
    'aesthetic'      : ['aes()', Key('left')],
    'coal'           : 'col',
    'size'           : 'size',
    'shape'          : 'shape',
    'fill'           : 'fill',
    'stroke'         : 'stroke',
    'geom point'     : ['geom_point()', Key('left')],
    'geom line'     : ['geom_line()', Key('left')],
    'geom smooth'    : ['geom_smooth(method="lm", se=TRUE, col=\'steelblue\')'],
    'cord cartesian' : ['coord_cartesian()', Key('left')],
    'labs'           : 'labs(title=NULL, subtitle=NULL, y=NULL, x=NULL, caption=NULL)',
    'ex limb'        : 'xlim',
    'why limb'       : 'ylim',
}; Rmap.update(ggplot)

ctx.keymap(Rmap)

