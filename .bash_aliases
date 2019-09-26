shopt -s expand_aliases

# -----------------------------------------------------------------------------
# SHARED BY ALL {{{
# -----------------------------------------------------------------------------

# abbreviations
alias p="python"
alias tlf="tail -f"
alias rmrf="rm -rf"
alias tarp="tar -zcvf"
alias untarp="tar -zxvf"
alias dush="du -sh"
alias rl="readlink -f"
alias mkdirp="mkdir -p"
alias lsla="ls -la"
alias h="head -n"
alias t="tail -n"
alias col="column -t"
alias eb="vim ~/.bashrc"
alias ep="vim ~/.bash_prompt"
alias et="vim ~/.talon/user/"
alias ea="vim ~/.bash_aliases"
alias sb="source ~/.bash_profile"
alias ev="vim ~/.vimrc"
alias hs="history | cut -c 8-"
alias yu="yadm add -u; yadm commit -m '$(date)'; yadm push origin master"

# changes title of the window from `old` to `new (old)` via `title new`
function title {
    echo -ne "\033]0;"$*"\007"
}

# -----------------------------------------------------------------------------
# }}} MY MACBOOK {{{
# -----------------------------------------------------------------------------

# specific to my macbook
if [ "$(uname -n)" == "$my_2016_macbook" ]; then
    alias anvio="source ~/virtual-envs/anvio-master/bin/activate"
    alias illumina="source ~/virtual-envs/illumina-utils-master/bin/activate"
    alias pymol="/Applications/MacPyMOL.app/Contents/MacOS/MacPyMOL"
    alias run_dragon="/Applications/Talon.app/Contents/Resources/run_dragon"
    alias barhali="ssh -L 8120:localhost:8120 -L 8121:localhost:8121 -L 8122:localhost:8122 -L 8123:localhost:8123 barhal | tee /dev/tty | python3 ~/.ssh/run_webbrowser.py"
    alias midwayer="ssh midway" # perhaps extended for interactive interface (like barhali)
    alias igv="bash /Users/evan/Software/IGV_2.3.97/igv.sh"
    alias patric="source '/Applications/PATRIC.app//user-env.sh'" # PATRIC CLI (genome downloading)
    alias tlog="tail -f ~/.talon/talon.log"

    # overwrites
    alias readlink="greadlink"
    alias vim="/usr/local/bin/vim"
    alias vi="/usr/local/bin/vim"

    # convenience variables (these are the only exports allowed in ~/.bash_aliases)
    export academics="/Users/evan/Academics"
    export anvenv="/Users/evan/virtual-envs/anvio-master/bin/activate"
    export anvio="/Users/evan/Software/anvio"
    export anviobin="/Users/evan/Software/anvio/bin"
    export anviosandbox="/Users/evan/Software/anvio/sandbox"
    export anviocode="/Users/evan/Software/anvio/anvio"
    export anviotests="/Users/evan/Software/anvio/anvio/tests"
    export anviooutput="/Users/evan/Software/anvio/anvio/tests/sandbox/test-output"
    export desktop="/Users/evan/Desktop"
    export documents="/Users/evan/Documents"
    export dotfiles="/Users/evan/Software/dotfiles"
    export dropbox="/Users/evan/Dropbox"
    export googledrive="/Users/evan/googledrive"
    export jortatap="/Users/evan/Academics/Research/Meren/JORTATAP"
    export meren="/Users/evan/Academics/Research/Meren"
    export software="/Users/evan/Software"
    export table2md="csvtomd"
    export talon="/Applications/Talon.app/Contents/Resources/talon_plugins"
    export talonscripts="/Users/evan/.talon/user"
fi

# -----------------------------------------------------------------------------
# }}} BARHAL {{{
# -----------------------------------------------------------------------------

# specific to barhal
if [ "$(uname -n)" == "$barhal_server" ]; then
    # convenience variables (these are the only exports allowed in ~/.bash_aliases)
    export anvenv="/groups/merenlab/virtual-envs/anvio-master/anvio/"
    export ekiefl="/groups/merenlab/people/ekiefl"
    export s="/users/ekiefl"
    export ekieflshared="/workspace/shared/ekiefl-shared/"
    export merenlab="/groups/merenlab"
    export merenlabshared="/workspace/shared/merenlab-shared"
    export anvenv="/groups/merenlab/virtual-envs/anvio-master/bin/activate"
fi

# -----------------------------------------------------------------------------
# }}} MIDWAY {{{
# -----------------------------------------------------------------------------

# specific to barhal
if [ "$(uname -n)" == "$midway_login1" ] || [ "$(uname -n)" == "$midway_login2" ]; then
    echo
fi

# -----------------------------------------------------------------------------
# }}}
# -----------------------------------------------------------------------------
