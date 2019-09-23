# welcome message
cat ~/.bash_welcome

#Define your own aliases here ...
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# autocorrects small mistakes
shopt -s cdspell

function get_dirname() {
    local dirname_out=$(dirname "${1}");
    echo "$dirname_out"
}

function get_basename() {
    local basename_out=$(basename "${1}")
    echo "$basename_out"
}

function split() {
    # 1st argument: variable, e.g. a="split-me-please"
    # 2nd argument: separator, e.g. -
    split_out=(${1//${2}/ });
}

# convenience variables
export academics="/Users/evan/Academics"
export anvio="/Users/evan/Software/anvio"
export codebase="/Users/evan/Software/anvio/anvio"
export anviotests="/Users/evan/Software/anvio/anvio/tests"
export anviooutput="/Users/evan/Software/anvio/anvio/tests/sandbox/test-output"
export desktop="/Users/evan/Desktop"
export documents="/Users/evan/Documents"
export dotfiles="/Users/evan/Software/dotfiles"
export dropbox="/Users/evan/Dropbox"
export googledrive="/Users/evan/googledrive"
export jortatap="/Users/evan/Academics/Research/Meren/JORTATAP"
export meren="/Users/evan/Academics/Research/Meren"
export software="/Users/evan/Software"
export table2md="csvtomd"
export talon="/Applications/Talon.app/Contents/Resources/talon_plugins"
export talonscripts="/Users/evan/.talon/user"
export vimbundle="/Users/evan/.vim/bundle"

# PS1 command_prompt bash_prompt
source ~/.bash_prompt

# ls coloring
export CLICOLOR=1
export LSCOLORS=gxhxCxDxBxegedabagaced

# python paths
export PYTHONPATH="${PYTHONPATH}:/Users/evan/Software/pymol-v1.8.6.0-Darwin-x86_64/modules"

# iterm
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# pyenv 
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# empty talon.log
rm ~/.talon/talon.log
touch ~/.talon/talon.log

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:~/.local/bin"
