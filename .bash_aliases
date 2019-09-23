shopt -s expand_aliases

# shortcuts
alias anvio="source ~/virtual-envs/anvio-master/bin/activate"
alias illumina="source ~/virtual-envs/illumina-utils-master/bin/activate"
alias mbl="ssh ekiefl@evol5.mbl.edu"
alias midway1="ssh ekiefl@midway-login1.rcc.uchicago.edu"
alias midway2="ssh ekiefl@midway-login2.rcc.uchicago.edu"
alias pymol="/Applications/MacPyMOL.app/Contents/MacOS/MacPyMOL"
alias run_dragon="/Applications/Talon.app/Contents/Resources/run_dragon"
alias desman2="source ~/virtual-envs/desman/bin/activate" # DESMAN 2 (is a virtual env)
alias desman3="source ~/virtual-envs/desman3/bin/activate" # DESMAN 3 (is a virtual env)
alias barhali="ssh -L 8120:localhost:8120 -L 8121:localhost:8121 -L 8122:localhost:8122 -L 8123:localhost:8123 barhal | tee /dev/tty | python3 ~/.ssh/run_webbrowser.py"
alias igv="bash /Users/evan/Software/IGV_2.3.97/igv.sh"
alias patric="source '/Applications/PATRIC.app//user-env.sh'" # PATRIC CLI


# overwrites
alias readlink="greadlink"
alias p="python"
alias vim="/usr/local/bin/vim"
alias vi="/usr/local/bin/vim"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../"
alias .....="cd ../../../.."

# abbreviations
alias tlf="tail -f"
alias tlog="tail -f ~/.talon/talon.log"
alias rmrf="rm -rf"
alias tarp="tar -zcvf"
alias untarp="tar -zxvf"
alias dush="du -sh"
alias rl="readlink -f"
alias mkdirp="mkdir -p"
alias lsla="ls -la"
alias h="head -n"
alias t="tail -n"
alias col="column -t"
alias eb="vim ~/.bash_profile"
alias ep="vim ~/.bash_prompt"
alias et="vim /Users/evan/.talon/user/"
alias ea="vim ~/.bash_aliases"
alias sb="source ~/.bash_profile"
alias ev="vim ~/.vimrc"
alias hs="history | cut -c 8-"

# changes title of the window from `old` to `new (old)` via `title new`
function title {
    echo -ne "\033]0;"$*"\007"
}
