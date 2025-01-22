# find name by typing `uname -n`
export MACHINE1="evans-Apple-MacBook-Pro:name2:name3"
export MACHINE2="DESKTOP-4BU1VKD"
export CURRENT_MACHINE="$(uname -n)"

# If you're scp-ing, we're done
if [ -z "$PS1" ]; then
    return
fi

if [ -f ~/.bash_welcome ]; then
    bash ~/.bash_welcome
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.bash_utils ]; then
    source ~/.bash_utils
fi

if [ -f ~/.bash_prompt ]; then
    source ~/.bash_prompt
fi

# ls coloring
export CLICOLOR=1
export LSCOLORS=gxhxCxDxBxegedabagaced

# autocorrects small mistakes
shopt -s cdspell

# Determine whether the default implementation should be used
if [[ "$MACHINE1" =~ "$CURRENT_MACHINE" ]]; then
    USE_DEFAULTS=true
elif [[ "$MACHINE2" =~ "$CURRENT_MACHINE" ]]; then
    USE_DEFAULTS=true
    export PATH="$PATH:/opt/nvim-linux64/bin"
elif [[ "$MACHINE3" =~ "$CURRENT_MACHINE" ]]; then
    # Maybe its a company script that's not yadm-tracked
    USE_DEFAULTS=false
    source ~/.company/bashrc
else
    USE_DEFAULTS=true
fi

# Default implementation
if [[ $USE_DEFAULTS == true ]]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    if [ -d "/opt/anaconda3" ]; then
        CONDA_PATH="/opt/anaconda3"
    elif [ -d "$HOME/anaconda3" ]; then
        CONDA_PATH="$HOME/anaconda3"
    elif [ -d "/opt/miniconda3" ]; then
        CONDA_PATH="/opt/miniconda3"
    elif [ -d "$HOME/miniconda3" ]; then
        CONDA_PATH="$HOME/miniconda3"
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

    eval "$(pixi completion --shell bash)"
fi

. "$HOME/.cargo/env"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
