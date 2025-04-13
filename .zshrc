# If not running interactively, don't do anything
[[ -o interactive ]] || return

export MACHINE1="evans-Apple-MacBook-Pro:name2:name3"
export MACHINE2="DESKTOP-4BU1VKD"
# export MACHINE3="some-other-machine"
#
export CURRENT_MACHINE="$(uname -n)"

if [ -f ~/.bash_welcome ]; then
  source ~/.bash_welcome
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.bash_utils ]; then
    source ~/.bash_utils
fi

# --- Machine-Specific Configuration ---

USE_DEFAULTS=false # Default to false unless explicitly matched

if [[ "$MACHINE1" == *"$CURRENT_MACHINE"* ]]; then
    USE_DEFAULTS=true
elif [[ "$MACHINE2" == *"$CURRENT_MACHINE"* ]]; then
    USE_DEFAULTS=true
    export PATH="$PATH:/opt/nvim-linux64/bin"
elif [[ -v MACHINE3 && "$MACHINE3" == *"$CURRENT_MACHINE"* ]]; then
    # Maybe its a company script that's not yadm-tracked
    USE_DEFAULTS=false
    source ~/.company/zshrc
else
    # If no specific machine matched, use defaults
    USE_DEFAULTS=true
fi

# --- Default Implementation (if USE_DEFAULTS is true) ---

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
fi

## --- Other Environment Setup ---

# Source Cargo environment if the file exists
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# Load RVM into a shell session *as a function*
# RVM script usually detects Zsh automatically
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm"
fi

# --- Shell

setopt CORRECT
setopt EXTENDED_GLOB

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
prompt clint
