from talon.voice import Word, Context, Key, Rep, Str, press
from talon import ctrl
import string

from .mouse import initial_pos_click

LOCAL_LEADER = ','

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
    'spear'      : ['$'],
    'exit'      : ['quit()', Key('left')],
    'apply'      : ['apply()', Key('left')],
    'install packages'      : ['install.packages()', Key('left')],
    'dim'      : ['dim()', Key('left')],
    'attribute'      : ['attr()', Key('left')],
    'etcetera'      : ['...'],
    'library'      : ['library()', Key('left')],
    'options'     : ['options()', Key('left')],
    'she bang'    : [Key('escape'), 'mtggO', '#!/usr/bin/env Rscript', Key('escape'), '\'t'],
    'null'     : 'NULL',
    'true'     : 'TRUE',
    'false'     : 'FALSE',
    'read csv' : ["read.csv(, sep='\\t')"] +  [Key('left')] * 11,
    'print' : ["print()", Key('left')],
    'loop' : ["for ()", Key('left')],
    'loop' : ["for ()", Key('left')],
    'function' : ["function()", Key('left')],
    'seek along' : ["seq_along()", Key('left')],
    'mod lint' : [" %in% "],
    'lint' : [" in "],
    'unpack' : [" %<-% "],
    'sift' : ["if ()", Key('left')],
    'else' : ["else"],
    'elsey' : [" else "],
    'return' : ["return()", Key('left')],
    'grepple' : ["grepl()", Key('left')],
    'split' : ["split()", Key('left')],
    'pastey' : ["paste()", Key('left')],
    'call names' : ['colnames()', Key('left')],
    'ro names' : ['rownames()', Key('left')],
    'names' : ['names()', Key('left')],
    'dimnames' : ['dimnames()', Key('left')],
    'veck' : ['c()', Key('left')],
    'list' : ['list()', Key('left')],
    'length' : ['length()', Key('left')],
    'unlist' : ['unlist()', Key('left')],
    'head' : ['head()', Key('left')],
    'tail' : ['tail()', Key('left')],
}; Rmap.update(basicR)

tidyverse = {
    'string split' : ['str_split()', Key('left')],
    'filter' : ['filter()', Key('left')],
    'arrange' : ['arrange()', Key('left')],
    'summarise' : ['summarise()', Key('left')],
    'mutate' : ['mutate()', Key('left')],
    'group by' : ['group_by()', Key('left')],
    'ungroup' : ['ungroup()', Key('left')],
    'think' : ['%>%'],
    'thinkert' : [' %>% '],
    'zen' : [Key('esc'), 'A %>%', Key('enter')],
    '(zad | sad)' : [Key('esc'), 'A +', Key('enter')],
}; Rmap.update(tidyverse)

ggplot = {
    'plot'    : 'ggplot',
    'g g save'    : ["ggsave(, plot = last_plot(), width=NA, height=NA, units='cm', dpi=300)"] + [Key('left')] * 63,
    'aesthetic'      : ['aes()', Key('left')],
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

Nvim = {
    'start are': [Key('esc'), LOCAL_LEADER, 'rf'],
    'quit are': [Key('esc'), LOCAL_LEADER, 'rq'],

    # jedi
    'pop'               :  Key('ctrl-x ctrl-o'),

    'help': [Key('esc'), initial_pos_click, LOCAL_LEADER, 'rh'],
    'example': [Key('esc'), initial_pos_click, LOCAL_LEADER, 're'],
    'view': [Key('esc'), initial_pos_click, LOCAL_LEADER, 'rv'],
    'show': [Key('esc'), initial_pos_click, LOCAL_LEADER, 'rp'],
    'structure': [Key('esc'), initial_pos_click, LOCAL_LEADER, 'rt'],
    'browse': [Key('esc'), LOCAL_LEADER, 'ro'],
    'summary': [Key('esc'), LOCAL_LEADER, 'rs'],

    'run all': [Key('esc'), LOCAL_LEADER, 'aa'],
    'run inline': [Key('esc'), initial_pos_click, LOCAL_LEADER, 'o'],
    'run fun': [Key('esc'), initial_pos_click, LOCAL_LEADER, 'fe'],
    'run block': [Key('esc'), initial_pos_click, LOCAL_LEADER, 'be'],
    'run': [Key('esc'), LOCAL_LEADER, 'se'],

}; Rmap.update(Nvim)

ctx.keymap(Rmap)

