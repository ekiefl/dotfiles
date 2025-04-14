# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-vi-mode)


source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# --------------------------------------------------------

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

## --- Vim

RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
RPS2=$RPS1

##### BINDINGS
bindkey "^R" history-incremental-search-backward
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

##### VIM STUFF
bindkey '\e' vi-cmd-mode

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
