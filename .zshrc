# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load
ZSH_THEME="gentoo"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(common-aliases sudo extract history-substring-search)

source $ZSH/oh-my-zsh.sh


# Final customization

# aliases
alias l="ls --color=auto --almost-all --classify --group-directories-first -v"
alias ls="ls --color=auto --almost-all --classify --group-directories-first -v"
alias ll="ls --color=auto --almost-all --classify --group-directories-first -lvh"
alias v=vim
alias vi=vim
alias sv="sudo vim"
alias g="grep --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

export EDITOR=vim
export PATH=$PATH:~/bin
export HISTCONTROL=ignoreboth

# keep everything in english, except time, numbers and currency
export LANG="en_US.UTF-8"
export LC_TIME="ru_RU.UTF-8"
export LC_NUMERIC="ru_RU.UTF-8"
export LC_MONETARY="ru_RU.UTF-8"

# search result displayed at 20% offset from top
export LESS="-j.2"

# color preferences for ls, tree and other similar commands
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=
30;42:ow=34;42:st=37;44:ex=01;32:'

# disable `sudo vim' correction to `.vim'
unsetopt correctall

# dunno why .screenrc didn't respect term option
if [ "$TERM" = "screen" ] ; then
    export TERM="screen-256color"
fi

# Function for quick navigation between similar dirs
# Consider your current working dir is /a/b/c/foo/x/y/z
# you execute `cdr bar` and it becomes /a/b/c/bar/x/y/z
function cdr () {
    replacement=$1
    array=(${=PWD//\// })
    # notice: arrays in zsh are 1 based
    for ((i = ${#array[@]}; i > 0; i--)); do
        directory=${PWD/${array[$i]}/$replacement}
        if [ -d $directory ]; then
            # show whats changed, and cd to new location
            echo $PWD
            echo $directory
            cd $directory
            return
        fi
    done
    echo "Valid path not found"
}
