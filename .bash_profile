# pull from yadm before anything
if hash yadm 2>/dev/null; then
    yadm pull
else
    echo 'yadm binary not found. dotfiles were not pulled'
fi

# bashrc contains all else
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

