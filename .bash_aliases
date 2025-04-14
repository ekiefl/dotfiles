# General
alias tlf="tail -f"
alias tarp="tar -zcvf"
alias untarp="tar -zxvf"
alias dush="du -sh"
alias rl="readlink -f"
alias ll="ls -la"
alias h="head -n"
alias t="tail -n"

# Aliases for editing config files
alias eu="vim ~/.bash_utils"
alias ea="vim ~/.bash_aliases"
alias ei="vim ~/.inputrc"
alias eb="vim ~/.zshrc"
alias ep="vim ~/.bash_prompt"
alias sb="source ~/.zprofile"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gd="git diff"
alias gc="git checkout"
alias gb="git branch"

# Yadm aliases
alias yu="yadm add -u; yadm commit -m \"\$(date)\"; yadm push origin master"
alias ys="yadm status"
alias yd="yadm diff"

# Screen aliases
alias ss="screen -S"
alias sls="screen -ls"
alias sx="screen -x"
alias sr="screen -r"

# Conda aliases
alias d="conda deactivate"
alias ca="conda activate"

# Jekyll aliases
alias js="bundle exec jekyll serve"
alias jsi="bundle exec jekyll serve --incremental"

title() {
    echo -ne "\033]0;"$*"\007"
}

if [[ "$MACHINE1" == *"$CURRENT_MACHINE"* ]]; then
    if [ -f ~/.arcadia/bash_aliases ]; then
        source ~/.arcadia/bash_aliases
    fi
elif [[ "$MACHINE2" == *"$CURRENT_MACHINE"* ]]; then
    alias vim=$(which nvim)
    export software="/Users/evan/Software"
else
    alias anvio="conda activate anvio-dev"
    alias pt="conda activate pooltool"
    alias pm="conda activate poolml"

    alias readlink="greadlink"
    alias vim=$(which nvim)
    alias vi=$(which nvim)

    export academics="/Users/evan/Academics"
    export nvim="/Users/evan/.config/nvim/"
    export pm="/Users/evan/Software/poolml"
    export pmc="/Users/evan/Software/poolml/poolml"
    export pms="/Users/evan/Software/poolml/poolml/data/scratch"
    export pmd="/Users/evan/Software/poolml/poolml/data"
    export pmdd="/Users/evan/Software/poolml/poolml/data/scratch/dump"
    export pt="/Users/evan/Software/pooltool_ml/pooltool"
    export ptc="/Users/evan/Software/pooltool_ml/pooltool/pooltool"
    export lz="/Users/evan/Software/pooltool_ml/LightZero/"
    export ptm="/Users/evan/Software/pooltool_ml"
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

