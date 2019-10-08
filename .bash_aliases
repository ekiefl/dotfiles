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
alias tl="tail -f ~/.talon/talon.log"
alias ea="vim ~/.bash_aliases"
alias ei="vim ~/.inputrc"
alias eb="vim ~/.bashrc"
alias ep="vim ~/.bash_prompt"
alias et="vim ~/.talon/user/"
alias ev="vim ~/.vimrc"
alias sb="source ~/.bash_profile"
alias gs="git status"
alias ga="git add"
alias gd="git diff"
alias gc="git commit -m"
alias hs="history | cut -c 8-"
alias yu="yadm add -u; yadm commit -m '$(date)'; yadm push origin master"
alias ys="yadm status"
alias yd="yadm diff"
alias yp="yadm pull"
alias ss="screen -S"
alias sls="screen -ls"
alias sx="screen -x"
alias sr="screen -r"

# changes title of the window from `old` to `new (old)` via `title new`
function title {
    echo -ne "\033]0;"$*"\007"
}

# -----------------------------------------------------------------------------
# }}} MY MACBOOK {{{
# -----------------------------------------------------------------------------

# specific to my macbook
if [[ "$my_2016_macbook" =~ "$(uname -n)" ]]; then
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
    export a="/Users/evan/Software/anvio"
    export ab="/Users/evan/Software/anvio/bin"
    export as="/Users/evan/Software/anvio/sandbox"
    export ac="/Users/evan/Software/anvio/anvio"
    export at="/Users/evan/Software/anvio/anvio/tests"
    export ao="/Users/evan/Software/anvio/anvio/tests/sandbox/test-output"
    export desktop="/Users/evan/Desktop"
    export documents="/Users/evan/Documents"
    export dotfiles="/Users/evan/Software/dotfiles"
    export dropbox="/Users/evan/Dropbox"
    export googledrive="/Users/evan/googledrive"
    export jortatap="/Users/evan/Academics/Research/Meren/JORTATAP"
    export m="/Users/evan/Academics/Research/Meren"
    export software="/Users/evan/Software"
    export table2md="csvtomd"
    export talon="/Applications/Talon.app/Contents/Resources/talon_plugins"
    export talonscripts="/Users/evan/.talon/user"
fi

# -----------------------------------------------------------------------------
# }}} BARHAL {{{
# -----------------------------------------------------------------------------

# specific to barhal
if [[ "$barhal_server" =~ "$(uname -n)" ]]; then
    # convenience variables (these are the only exports allowed in ~/.bash_aliases)
    export anvenv="/groups/merenlab/virtual-envs/anvio-master/anvio/"
    export ek="/groups/merenlab/people/ekiefl"
    export s="/users/ekiefl"
    export ekieflshared="/workspace/shared/ekiefl-shared/"
    export ml="/groups/merenlab"
    export merenlabshared="/workspace/shared/merenlab-shared"
    export anvenv="/groups/merenlab/virtual-envs/anvio-master/bin/activate"
fi

# -----------------------------------------------------------------------------
# }}} MIDWAY {{{
# -----------------------------------------------------------------------------

# specific to barhal
if [[ "$midway_server" =~ "$(uname -n)" ]]; then
    alias anvio="conda activate /project2/meren/VIRTUAL-ENVS/anvio-master/"
    alias cl="clusterize"
    alias q="sinfo --partition=meren -N -o '%N %P %11T %20E %4c %8z %6m %8e %8d %l %L %g'; echo ; squeue --partition=meren -o '%10i %45j %5u %5C %13m %8T %10M %9l %6D %R'"
    alias qe="squeue --user=ekiefl -o '%10i %30j %5u %8T %10M %9l %6D %R %5C %13m %15N'"
    alias sc="scancel"

    # convenience variables only
    export a="/project2/meren/VIRTUAL-ENVS/anvio-master/anvio"
    export ab="/project2/meren/VIRTUAL-ENVS/anvio-master/anvio/bin"
    export as="/project2/meren/VIRTUAL-ENVS/anvio-master/anvio/sandbox"
    export ac="/project2/meren/VIRTUAL-ENVS/anvio-master/anvio/anvio"
    export at="/project2/meren/VIRTUAL-ENVS/anvio-master/anvio/anvio/tests"
    export ao="/project2/meren/VIRTUAL-ENVS/anvio-master/anvio/anvio/tests/sandbox/test-output"
    export ml="/project2/meren/"
    export ek="/project2/meren/PEOPLE/ekiefl"
    export snake="anvi-run-workflow -w FIXME -c config.json --additional-params --cluster \"clusterize -j={rule} -o={log} -e={log} -n={threads} -x\" --jobs FIXME --resource nodes=FIXME --latency-wait 100"

    export jortatap="/project2/meren/PEOPLE/ekiefl/JORTATAP"
fi

# -----------------------------------------------------------------------------
# }}}
# -----------------------------------------------------------------------------
