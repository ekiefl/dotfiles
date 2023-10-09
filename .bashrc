# find by typing `uname -n`
export my_2016_macbook="Evans-MacBook-Pro.local:Evans-MBP-9e79:Evans-MBP.APT307:Evans-MBP.example.com:Kourtneys-MacBook-Air.local:Evans-MBP.attlocal.net"
export barhal_server="barhal-01.bpcservers.private"
export midway_server="midway2-login1.rcc.local:midway2-login2.rcc.local:midway-l16b-28.rcc.local:midway2-0701.rcc.local:midway2-0705.rcc.local:midway2-0706.rcc.local"
export midway3_server="midway3-login1.rcc.local:midway3-login2.rcc.local"
export abc="AB-FVFHL03BQ05P"
export spml="ip-172-31-62-139"

# -----------------------------------------------------------------------------
# SHARED BY ALL {{{
# -----------------------------------------------------------------------------

# if you're scp-ing, we're done
if [ -z "$PS1" ]; then
    return
fi

# welcome message
bash ~/.bash_welcome

# Define your aliases here ...
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Define your aliases here ...
if [ -f ~/.bash_utils ]; then
    source ~/.bash_utils
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
# }}} ABC {{{
# -----------------------------------------------------------------------------

if [[ "$abc" =~ "$(uname -n)" ]]; then
    source ~/.bashrc_abc
fi

# -----------------------------------------------------------------------------
# }}} SPML {{{
# -----------------------------------------------------------------------------

if [[ "$spml" =~ "$(uname -n)" ]]; then
    source ~/.bashrc_abc
fi

# -----------------------------------------------------------------------------
# }}} MY MACBOOK {{{
# -----------------------------------------------------------------------------

if [[ "$my_2016_macbook" =~ "$(uname -n)" ]]; then
    # python paths
    export PYTHONPATH="${PYTHONPATH}:/Users/evan/Software/pymol-v1.8.6.0-Darwin-x86_64/modules"

    # empty talon.log
    rm ~/.talon/talon.log
    touch ~/.talon/talon.log

    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="$PATH:~/.local/bin"

    function worklog {
        echo "$(date): $@" >> ~/.worklog
    }

    # Add ruby to path
    export PATH="/Users/evan/.gem/ruby/2.7.0/bin:$PATH"

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    if [ -d "/Users/evan/anaconda3" ]; then
        CONDA_PATH="/Users/evan/anaconda3"
    elif [ -d "/Users/evan/miniconda3" ]; then
        CONDA_PATH="/Users/evan/miniconda3"
    else
        echo "No conda installation found."
    fi

    __conda_setup="$("$CONDA_PATH/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
            . "$CONDA_PATH/etc/profile.d/conda.sh"
        else
            export PATH="$CONDA_PATH/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    if [ -n "${_CONDA_EXE}" ]; then
        export CONDA_ENV_PROMPT_PREFIX="[\[\033[01;31m\]%s\[\033[00m\]]"
    fi

fi

# -----------------------------------------------------------------------------
# }}} BARHAL {{{
# -----------------------------------------------------------------------------

if [[ "$barhal_server" =~ "$(uname -n)" ]]; then
    # nothing so far
    echo
fi

# -----------------------------------------------------------------------------
# }}} MIDWAY {{{
# -----------------------------------------------------------------------------

if [[ "$midway_server" =~ "$(uname -n)" ]]; then
    # load modules
    module load vim/8.1
    #module load rstudio/1.2.1335 # use to work but now fails upon command: `R`
    module load R

    # add some programs to the PATH variable
    export PATH=$PATH:/project2/meren/RESOURCES/PUBLIC/SOFTWARE
    export PATH=$PATH:/project2/meren/RESOURCES/PUBLIC/SOFTWARE/seqtk
    export PATH=$PATH:/project2/meren/RESOURCES/PUBLIC/SOFTWARE/trimal/source

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

    # proper vim colors in screens
    export TERM=xterm-256color
fi

# -----------------------------------------------------------------------------
# }}} MIDWAY3 {{{
# -----------------------------------------------------------------------------

if [[ "$midway3_server" =~ "$(uname -n)" ]]; then
    #module load rstudio/1.2.1335 # use to work but now fails upon command: `R`
    module load R

    function go_alphafold {
        if hash conda 2>/dev/null; then
            conda deactivate
        else
            :
        fi
        module load python/anaconda-2021.05
        module load nvhpc
        source activate alphafold
    }
    function stop_alphafold {
        conda deactivate
        module unload python/anaconda-2021.05
        module unload nvhpc
    }

    # proper vim colors in screens
    export TERM=xterm-256color
fi

# -----------------------------------------------------------------------------
# }}}
# -----------------------------------------------------------------------------

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
