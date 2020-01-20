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
