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
alias eu="vim ~/.bash_utils"
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
alias ah="anvi-help"
alias d="deactivate && conda deactivate"
alias ca="conda activate"
alias js="bundle exec jekyll serve"
alias jsi="bundle exec jekyll serve --incremental"

# changes title of the window from `old` to `new (old)` via `title new`
function title {
    echo -ne "\033]0;"$*"\007"
}

# -----------------------------------------------------------------------------
# }}} MY MACBOOK {{{
# -----------------------------------------------------------------------------

# specific to my macbook
if [[ "$my_2016_macbook" =~ "$(uname -n)" ]]; then
    #alias python="python3"
    alias anvio="conda activate anvio-master && source ~/virtual-envs/anvio-master/bin/activate"
    alias pt="conda activate pool"
    alias maple="conda activate maple"
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
    export pt="/Users/evan/Software/pool"
    export maple="/Users/evan/Software/maple"
    export a="/Users/evan/Software/anvio"
    export ab="/Users/evan/Software/anvio/bin"
    export as="/Users/evan/Software/anvio/sandbox"
    export ac="/Users/evan/Software/anvio/anvio"
    export at="/Users/evan/Software/anvio/anvio/tests"
    export ao="/Users/evan/Software/anvio/anvio/tests/sandbox/test-output"
    export asp="/Users/evan/Dropbox/anvio-structure-paper/" # temp
    export d="/Users/evan/Desktop"
    export documents="/Users/evan/Documents"
    export dotfiles="/Users/evan/Software/dotfiles"
    export dropbox="/Users/evan/Dropbox"
    export googledrive="/Users/evan/googledrive"
    export jortatap="/Users/evan/Academics/Research/Meren/JORTATAP"
    export m="/Users/evan/Academics/Research/Meren"
    export software="/Users/evan/Software"
    export ekiefl="/Users/evan/Software/ekiefl.github.io"
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

# specific to midway
if [[ "$midway_server" =~ "$(uname -n)" ]]; then
    alias cl="clusterize"
    alias clh="column -t ~/.clusterize_history | tail"
    alias q="sinfo --partition=meren -N -o '%N %P %11T %20E %C %8m %8e %8d'; echo ; \
             squeue --partition=meren -o '%11i %35j %8u %5C %13m %8T %10M %9l %6D %R'; echo ; \
             squeue --partition=meren --user=$USER -O 'arrayjobid:13,name:35,stdout:120'"
    alias qe="squeue --user=ekiefl -o '%11i %35j %5C %13m %8T %10M %9l %6D %R'"
    alias qq="sinfo --partition=meren -N -o '%N %P %11T %20E %C %6m %8e %8d'; echo ; \
              squeue --partition=meren -o '%11i %35j %8u %5C %13m %8T %10M %9l %6D %R'; echo ; \
              squeue --partition=meren -O 'arrayjobid:13,name:35,stdout:120'"
    alias sc="scancel"

    alias si="sinteractive --partition=meren --time=08:00:00 --mem=100G --nodelist midway-l16b-28 --exclude midway2-0701,midway2-0705,midway2-0706"
    alias sai="sinteractive --partition=meren --time=03:00:00 --mem=50G --nodelist midway2-0701,midway2-0705,midway2-0706 --exclude midway-l16b-28" # specifically for anvi-interactive sessions

    # upside stuff
    function go_upside {
        conda deactivate
        module load cmake hdf5_hl eigen gcc
        conda activate upside
        export PATH=$PATH:~/upside_scripts
    }
    function stop_upside {
        conda deactivate
        module unload cmake hdf5_hl eigen gcc
    }
    export jupe="let ipnport=($UID-6025)%65274; ipnip=$(dig +short myip.opendns.com @resolver1.opendns.com); jupyter notebook --ip=$ipnip --port=$ipnport --no-browser"
    alias upside="go_upside"
    alias downside="stop_upside"

    alias anvi-activate-master="conda activate /project2/meren/VIRTUAL-ENVS/anvio-master/; set_anvio_paths /project2/meren/VIRTUAL-ENVS/anvio-master"
    alias anvi-activate-evan="conda activate /project2/meren/PEOPLE/ekiefl/anvio-evan/; set_anvio_paths /project2/meren/PEOPLE/ekiefl/anvio-evan"
    alias aam="anvi-activate-master"
    alias aae="anvi-activate-evan"
    function set_anvio_paths {
        export a="$1/anvio"
        export ab="$1/anvio/bin"
        export as="$1/anvio/sandbox"
        export ac="$1/anvio/anvio"
        export at="$1/anvio/anvio/tests"
        export ao="$1/anvio/anvio/tests/sandbox/test-output"
    }

    export sags="/project2/meren/PEOPLE/ekiefl/JORTATAP/V01/PACHIADAKI_SAGS"
    export dev="/project2/meren/PROJECTS/3DEV_PAPER"
    export ml="/project2/meren/"
    export ek="/project2/meren/PEOPLE/ekiefl"
    export snake="anvi-run-workflow -w FIXME -c config.json --additional-params --cluster \"clusterize -j={rule} -o={log} -n={threads} -x\" --jobs FIXME --resource nodes=FIXME --latency-wait 100 --rerun-incomplete"

    export jortatap="/project2/meren/PEOPLE/ekiefl/JORTATAP"
fi

# -----------------------------------------------------------------------------
# }}}
# -----------------------------------------------------------------------------
