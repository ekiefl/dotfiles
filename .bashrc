# find name by typing `uname -n`
export MACHINE1="name1:name2"
export MACHINE1="name3:name4"

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

if [[ "$MACHINE1" =~ "$CURRENT_MACHINE" ]]; then
    # You can do your machine specific initialization here
    echo hi
elif [[ "$MACHINE2" =~ "$CURRENT_MACHINE" ]]; then
    # Maybe its a company script that's not yadm-tracked
    source ~/.bashrc_company
else
    # Fallback for unspecified machines

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

