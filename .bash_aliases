shopt -s expand_aliases

alias tlf="tail -f"
alias tarp="tar -zcvf"
alias untarp="tar -zxvf"
alias dush="du -sh"
alias rl="readlink -f"
alias ll="ls -la"
alias h="head -n"
alias t="tail -n"
alias eu="vim ~/.bash_utils"
alias ea="vim ~/.bash_aliases"
alias ei="vim ~/.inputrc"
alias eb="vim ~/.bashrc"
alias ep="vim ~/.bash_prompt"
alias ev="vim ~/.vimrc"
alias sb="source ~/.bash_profile"
alias gs="git status"
alias ga="git add"
alias gd="git diff"
alias gc="git checkout"
alias gb="git branch"
alias gu="git add -u; git commit -m '$(date)'; git push"
alias yu="yadm add -u; yadm commit -m '$(date)'; yadm push origin master"
alias ys="yadm status"
alias yd="yadm diff"
alias ss="screen -S"
alias sls="screen -ls"
alias sx="screen -x"
alias sr="screen -r"
alias d="conda deactivate"
alias ca="conda activate"
alias js="bundle exec jekyll serve"
alias jsi="bundle exec jekyll serve --incremental"

# changes title of the window from `old` to `new (old)` via `title new`
function title {
    echo -ne "\033]0;"$*"\007"
}

if [[ "$MACHINE1" =~ "$CURRENT_MACHINE" ]]; then
    echo "hi"
elif [[ "$MACHINE2" =~ "$CURRENT_MACHINE" ]]; then
    echo "hi"
else
    alias anvio="conda activate anvio-dev"
    alias pt="conda activate pooltool"
    alias pm="conda activate poolml"

    # overwrites
    alias readlink="greadlink"
    alias vim=$(which nvim)
    alias vi=$(which nvim)

    # convenience variables (these are the only exports allowed in ~/.bash_aliases)
    export academics="/Users/evan/Academics"
    export nvim="/Users/evan/.config/nvim/"
    export pm="/Users/evan/Software/poolml"
    export pmc="/Users/evan/Software/poolml/poolml"
    export pms="/Users/evan/Software/poolml/poolml/data/scratch"
    export pmd="/Users/evan/Software/poolml/poolml/data"
    export pmdd="/Users/evan/Software/poolml/poolml/data/scratch/dump"
    export pt="/Users/evan/Software/pooltool"
    export ptc="/Users/evan/Software/pooltool/pooltool"
    export pta="/Users/evan/Software/pooltool/pooltool/ani"
    export pti="/Users/evan/Software/pooltool/pooltool/ani/image"
    export a="/Users/evan/Software/anvio"
    export ab="/Users/evan/Software/anvio/bin"
    export as="/Users/evan/Software/anvio/sandbox"
    export ac="/Users/evan/Software/anvio/anvio"
    export at="/Users/evan/Software/anvio/anvio/tests"
    export ao="/Users/evan/Software/anvio/anvio/tests/sandbox/test-output"
    export d="/Users/evan/Desktop"
    export software="/Users/evan/Software"
    export ekiefl="/Users/evan/Software/ekiefl.github.io"
fi
