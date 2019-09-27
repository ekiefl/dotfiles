# find by typing `uname -n`
export my_2016_macbook="Evans-MacBook-Pro.local"
export barhal_server="barhal-01.bpcservers.private"
export midway_login1="midway2-login1.rcc.local"
export midway_login2="midway2-login2.rcc.local"

# -----------------------------------------------------------------------------
# SHARED BY ALL {{{
# -----------------------------------------------------------------------------

# welcome message
bash ~/.bash_welcome

# Define your aliases here ...
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# autocorrects small mistakes
shopt -s cdspell

# PS1 command_prompt bash_prompt
source ~/.bash_prompt

# ls coloring
export CLICOLOR=1
export LSCOLORS=gxhxCxDxBxegedabagaced

# iterm
source ~/.iterm2_shell_integration.bash

# -----------------------------------------------------------------------------
# }}} MY MACBOOK {{{
# -----------------------------------------------------------------------------

if [ "$(uname -n)" == "$my_2016_macbook" ]; then
    # python paths
    export PYTHONPATH="${PYTHONPATH}:/Users/evan/Software/pymol-v1.8.6.0-Darwin-x86_64/modules"

    # pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    # empty talon.log
    rm ~/.talon/talon.log
    touch ~/.talon/talon.log

    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="$PATH:~/.local/bin"
fi

# -----------------------------------------------------------------------------
# }}} BARHAL {{{
# -----------------------------------------------------------------------------

if [ "$(uname -n)" == "$barhal_server" ]; then
    # nothing so far
    echo
fi

# -----------------------------------------------------------------------------
# }}} MIDWAY {{{
# -----------------------------------------------------------------------------

if [ "$(uname -n)" == "$midway_login1" ] || [ "$(uname -n)" == "$midway_login2" ]; then
    # load modules
    module load Anaconda3/5.3.0
    module load vim/8.1

    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/software/Anaconda3-5.3.0-el7-x86_64/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/software/Anaconda3-5.3.0-el7-x86_64/etc/profile.d/conda.sh" ]; then
            . "/software/Anaconda3-5.3.0-el7-x86_64/etc/profile.d/conda.sh"
        else
            export PATH="/software/Anaconda3-5.3.0-el7-x86_64/bin:$PATH"
        fi
    fi
    unset __conda_setup

    # get rid of bash prompt prefix
    conda config --set changeps1 False

    cd /project2/meren/VIRTUAL-ENVS/anvio-master/anvio; git pull
fi

# -----------------------------------------------------------------------------
# }}}
# -----------------------------------------------------------------------------


