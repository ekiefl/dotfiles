# find by typing `uname -n`
export my_2016_macbook="Evans-MacBook-Pro.local"
export barhal_server="barhal-01.bpcservers.private"
export midway1_server="midway-login1"
export midway2_server="midway-login2"

###############################################################################
# SHARED BY ALL {{{
###############################################################################

# welcome message
cat ~/.bash_welcome

# Define your aliases here ...
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# autocorrects small mistakes
shopt -s cdspell

# PS1 command_prompt bash_prompt
source ~/.bash_prompt

# ls coloring
export CLICOLOR=1
export LSCOLORS=gxhxCxDxBxegedabagaced

# iterm
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

###############################################################################
# }}} MY MACBOOK {{{
###############################################################################

if [ $(uname -n) == $my_2016_macbook ]; then
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

###############################################################################
# }}}
###############################################################################
