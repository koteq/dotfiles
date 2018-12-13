# Bobthefish theme config
set -g theme_nerd_fonts yes
set -g theme_powerline_fonts no
set -g theme_display_date no
set -g theme_display_ruby no
set -g theme_display_git no

# Add home bin
set PATH $PATH ~/bin/

# Ls for humans
alias ls 'ls --color=auto --almost-all --classify --group-directories-first -v'

# Show search results with some offset from the screen edges
set -x LESS "-j.3"
