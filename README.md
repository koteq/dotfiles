Dotfiles
========

Install all useful crap
```
zsh vim git tree screen ncurses-term
```

Install oh-my-zsh
```
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
```

Grab dotfiles
```
wget --no-check-certificate https://raw.github.com/koteq/dotfiles/master/install.sh -O - | sh
```

Configure your terminal to use 256 colors
```
urxvt-256color putty-256color
```

[Optional] Remove backups
```
rm ~/.zshrc.original* ~/.screenrc.original* ~/.vimrc.original*
```
