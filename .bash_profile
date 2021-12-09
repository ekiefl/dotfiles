# this is where I store my binaries when I don't have write access,
# so exporting this path is the absolute first order of business
export PATH=$PATH:~/.local/bin

# pull from yadm before anything
if hash yadm 2>/dev/null; then
    yadm pull
else
    echo 'yadm binary not found. dotfiles were not pulled. install here: https://github.com/TheLocehiliosan/yadm'
fi

# bashrc contains all else
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

##
# Your previous /Users/evan/.bash_profile file was backed up as /Users/evan/.bash_profile.macports-saved_2021-05-17_at_13:56:44
##

# MacPorts Installer addition on 2021-05-17_at_13:56:44: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/evan/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/evan/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/evan/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/evan/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

