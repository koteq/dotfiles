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
plugins=(archlinux extract history-substring-search)

source $ZSH/oh-my-zsh.sh


# Final customization

# aliases
alias l=ls++
alias ls="ls -A"
alias ll="ls -lAh"
alias df="df -h"
alias v=vim
alias sv="sudo vim"
alias g=grep

export EDITOR="vim"
export PATH=$PATH:~/bin

# search result displayed at 20% offset from top
export LESS="-j.2"

# disable `sudo vim' correction to `.vim'
unsetopt correctall

# dunno why .screenrc didn't respect term option
if [ "$TERM" = "screen" ] ; then
    export TERM="screen-256color"
fi
