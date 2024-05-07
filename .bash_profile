# this is where I store my binaries when I don't have write access,
# so exporting this path is the absolute first order of business
export PATH=$PATH:~/.local/bin

# pull from yadm before anything
if hash yadm 2>/dev/null; then
    yadm pull
else
    echo 'yadm binary not found. dotfiles were not pulled. install here: https://github.com/TheLocehiliosan/yadm'
fi

# Add Homebrew to PATH if installed
if [[ -d "/opt/homebrew/bin" ]]; then
    # Apple Silicon Macs
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d "/usr/local/bin/brew" ]]; then
    # Other
    eval "$(/usr/local/bin/brew shellenv)"
fi

# bashrc contains all else
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:/Users/evan/.pixi/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
