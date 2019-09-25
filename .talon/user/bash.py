from talon.voice import Word, Key, Rep, Str, press
from .user_context import Context

"""
ctx: shared by all servers
ctx_local: specific to my local computer
ctx_barhal: specific to barhal
ctx_midway: specific to midway1 and midway2
"""
ctx = Context('bash', bundle='com.googlecode.iterm2')
ctx_local = Context('bash_local', bundle='com.googlecode.iterm2', func=lambda app, win: 'Evans-MacBook-Pro' in win.title)
ctx_barhal = Context('bash_barhal', bundle='com.googlecode.iterm2', func=lambda app, win: 'barhal-01.bpcservers.private' in win.title)
ctx_midway = Context('bash_midway', bundle='com.googlecode.iterm2', func=lambda app, win: any(s in win.title for s in ('midway-login1', 'midway-login2')))

bashmap = {}
bashmap_local = {}
bashmap_barhal = {}
bashmap_midway = {}

from .vim import common_to_bash # There is commonality because my bash inputrc is vim-styled
from .std import lower_upper_digits
from .mouse import initial_pos_dubclick

import os
import time
import glob

from datetime import datetime
# -----------------------------------------------------------------------------
# SHARED BY ALL {{{
# -----------------------------------------------------------------------------

mouse_map = {
    "passit"  : [initial_pos_dubclick, Key("cmd-v")],
    "passirk" : [initial_pos_dubclick, Key("cmd-v enter")],
    "cd here" : [initial_pos_dubclick, "cd ", Key("cmd-v"), Key("enter")],
    "ellis here" : [initial_pos_dubclick, "ls ", Key("cmd-v"), Key("enter")],
    "trippy here" : [initial_pos_dubclick, "source treepy -q ", Key("cmd-v"), Key("enter")],
}; bashmap.update(mouse_map)

iterm_map = { # This belongs in its own script file
    "fourth"  : Key('cmd-l'),
    "back"    : Key('cmd-h'),
    "tab new" : Key('cmd-t'),
}; bashmap.update(iterm_map)

builtins = {
    "echo"           : "echo ",
    "ssh"           : "ssh ",
    "source"        : "source ",
    "man"        : "man ",
    "sudo"          : "sudo ",
    'cd'            : 'cd ',
    'ellis'         : 'ls ',
    'remove'        : 'rm ',
    'cat'           : 'cat ',
    'grep'          : 'grep ',
    'diff'          : 'diff ',
    'sim link'      : 'ln ',
    'sea-eight mod' : 'chmod ',
    "history"       : ['hs', Key('enter')],
    "screen"        : "screen ",
    "leave screen"  : [Key("ctrl-a"), lambda m: time.sleep(0.25), Key("ctrl-d")],
    "kaput"         : "cp ",
    'which'         : 'which ',
    "open"          : "open ",
    "gzip"          : "gzip ",
    "untar"         : "tar -zxvf ",
    "douche"        : "du -sh ",
    'scp'           : 'scp ',
    'read link'     : "readlink -f ",
    'move'          : 'mv ',
    "tar"           : "tar -zcvf ",
    'python'        : 'python ',
    'our mrf'       : 'rm -rf ',
    'make durp'     : 'mkdir -p ',
    'head'          : 'head -n 10 ',
    'tail'          : 'tail -n 10 ',
    'run ellis'     : ['ls', Key('enter')],
    'run ellis LA'  : ['ls -la', Key('enter')],
    'tailff'        : 'tail -f ',
    'column'        : 'column -t ',
    'F G'           : ['fg', Key("enter")],
    'ground'        : [Key("esc"), Key("ctrl-z")],
    'bartsch'       : 'bash ',
}; bashmap.update(builtins)


programs = {
    "pip"          : "pip ",
    "pip install"  : "pip install ",
    "barhally"     : ["barhali", Key("enter"), "source $anvenv", Key("enter")],
    'deactivate'   : 'deactivate ',
    "(vim | fim)"  : "vim ",
    "anvy"         : ["anvi-", Key("tab"), Key("tab"), "y"],
    'jupiter'      : ['jupyter notebook', Key("enter")],
    'virtual env'  : 'virtualenv ',
    'pie env'      : 'pyenv ',
    'ipython'      : 'ipython ',
    'our script'   : 'Rscript ',
    'talon log'    : ['tail -f ~/.talon/talon.log', Key("enter")],
}; bashmap.update(programs)

git_map = {
    'run get'          : 'git ',
    'run get clone'    : 'git clone ',
    'run get diff'     : 'git diff ',
    'run get branch'   : 'git branch ',
    'run get commit'   : ['git commit -m ""', Key("left")],
    'run get push'     : 'git push origin master',
    'run get pull'     : 'git pull ',
    'run get status'   : ['git status', Key("enter")],
    'run get add'      : 'git add ',
    'run get reset'    : 'git reset --hard HEAD ',
    'run get checkout' : 'git checkout ',
    'yadam'          : 'yadm ',
    'yadam clone'    : 'yadm clone ',
    'yadam diff'     : 'yadm diff ',
    'yadam branch'   : 'yadm branch ',
    'yadam commit'   : ['yadm commit -m ""', Key("left")],
    'yadam push'     : 'yadm push origin master',
    'yadam pull'     : 'yadm pull ',
    'yadam status'   : ['yadm status', Key("enter")],
    'yadam add'      : 'yadm add ',
    'yadam reset'    : 'yadm reset --hard HEAD ',
    'yadam checkout' : 'yadm checkout ',
    'yadam update' :  [Key("esc"), "a", "yadm add -u; yadm commit -m '{}'; yadm push origin master".format(datetime.now()), Key("enter")],
}; bashmap.update(git_map)

names_map = {
    "mbl"                    :  "mbl",
    "bar hall"               :  "barhal",

    '(dock dock | dockdock)' :  '../',
    "sacramento"             :  [Key("esc"), "I#", Key("esc enter")],

    # convenience variables
    'snap academics'     : ["$academics/"],
    'snap anvio'         : ["$anvio/"],
    'snap anvio output'  : ["$anviooutput/"],
    'snap anvio tests'   : ["$anviotests/"],
    'snap jort a tap'    : ["$jortatap/"],
    'snap anviocode'     : ["$anviocode/"],
    'snap desktop'       : ["$desktop/"],
    'snap documents'     : ["$documents/"],
    'snap dot files'     : ["$dotfiles/"],
    'snap meren'         : ["$meren/"],
    'snap software'      : ["$software/"],
    'snap talon'         : ["$talon/"],
    'snap talon scripts' : ["$talonscripts/"],
    'snap temp'          : ["$temp/"],
    'snap dropbox'       : ["$dropbox/"],
}; bashmap.update(names_map)

# anvio programs
anvio_programs = [os.path.basename(x) for x in glob.glob('/Users/evan/Software/anvio/bin/*') \
                                               + glob.glob('/Users/evan/Software/anvio/sandbox/*') \
                                               if 'README' not in x]
anvio_map = {p.replace('-',' '): p+' ' for p in anvio_programs}; bashmap.update(anvio_map)

directory_marking = {}
directory_marking.update({("sticky %s" % x, "export %s=`pwd`" % y) for x, y in lower_upper_digits.items()})
directory_marking.update({("telly %s" % x,  "cd $%s; pwd; ls" % y) for x, y in lower_upper_digits.items()})
for key, value in directory_marking.items():
    directory_marking[key] = [value, Key("enter")]
bashmap.update(directory_marking)

#air arch = " -a "; ship air arch = " -A "
flags_map = {("%s arch" % x, " -%s " % y) for x, y in lower_upper_digits.items()}
bashmap.update(flags_map)

bashmap.update(common_to_bash)
ctx.keymap(bashmap)

# -----------------------------------------------------------------------------
# }}} BARHAL ONLY {{{
# -----------------------------------------------------------------------------

programs = {
    "source anvio" : ["source $anvenv", Key("enter")],
    "qstat full"   : ['qstat2', Key("enter")],
    "qstat"        : ['qstat', Key("enter")],
    "qstat me"     : ['qstat -u ekiefl', Key("enter")],
    "qdel"         : "qdel ",
    'cluster rise' : 'clusterize -n ',
}; bashmap_barhal.update(programs)

names_map = {
    'snap marrin lab' : ['/groups/merenlab/'],
    'snap storage data' : ['/storage/data/'],
}; bashmap_barhal.update(names_map)

ctx_barhal.keymap(bashmap_barhal)

# -----------------------------------------------------------------------------
# }}} MIDWAY ONLY {{{
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# }}}
# -----------------------------------------------------------------------------
