[ -f ~/.zshrc ] && cp --backup=numbered ~/.zshrc ~/.zshrc.original
wget --no-verbose --no-check-certificate https://raw.github.com/thekot/dotfiles/master/.zshrc -O ~/.zshrc

[ -f ~/.vimrc ] && cp --backup=numbered ~/.vimrc ~/.vimrc.original
wget --no-verbose --no-check-certificate https://raw.github.com/thekot/dotfiles/master/.vimrc -O ~/.vimrc

[ -f ~/.screenrc ] && cp --backup=numbered ~/.screenrc ~/.screenrc.original
wget --no-verbose --no-check-certificate https://raw.github.com/thekot/dotfiles/master/.screenrc -O ~/.screenrc

# ~/.vim directory structure
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/ftdetect
mkdir -p ~/.vim/indent
mkdir -p ~/.vim/syntax

# vim jellybeans colors theme
wget --no-verbose --no-check-certificate https://raw.github.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim -O ~/.vim/colors/jellybeans.vim

# vim nginx syntax files
wget --no-verbose http://hg.nginx.org/nginx/raw-file/tip/contrib/vim/ftdetect/nginx.vim -O ~/.vim/ftdetect/nginx.vim
wget --no-verbose http://hg.nginx.org/nginx/raw-file/tip/contrib/vim/indent/nginx.vim -O ~/.vim/indent/nginx.vim
wget --no-verbose http://hg.nginx.org/nginx/raw-file/tip/contrib/vim/syntax/nginx.vim -O ~/.vim/syntax/nginx.vim
