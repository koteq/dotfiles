# Bobthefish theme config
set -g theme_nerd_fonts yes
set -g theme_powerline_fonts no
set -g theme_display_date no
set -g theme_display_ruby no
set -g theme_display_git no

# Add home bin
set PATH $PATH ~/bin/

# Set language to English but with Russian locale
set -x LANG en_US.UTF-8
set -x LC_TIME ru_RU.UTF-8
set -x LC_NUMERIC ru_RU.UTF-8
set -x LC_MONETARY ru_RU.UTF-8

# Ls for humans
alias ls 'ls --color=auto --almost-all --classify --group-directories-first -v'

# Show search results with some offset from the screen edges
set -x LESS "-j.3"
