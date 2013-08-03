[ -f ~/.zshrc ] && cp --backup=numbered ~/.zshrc ~/.zshrc.original
wget --no-verbose --no-check-certificate https://raw.github.com/thekot/dotfiles/master/.zshrc -O ~/.zshrc

[ -f ~/.vimrc ] && cp --backup=numbered ~/.vimrc ~/.vimrc.original
wget --no-verbose --no-check-certificate https://raw.github.com/thekot/dotfiles/master/.vimrc -O ~/.vimrc

[ -f ~/.screenrc ] && cp --backup=numbered ~/.screenrc ~/.screenrc.original
wget --no-verbose --no-check-certificate https://raw.github.com/thekot/dotfiles/master/.screenrc -O ~/.screenrc

mkdir -p ~/.vim/swap
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/colors
wget --no-verbose --no-check-certificate https://raw.github.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim -O ~/.vim/colors/jellybeans.vim