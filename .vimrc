set nocompatible
scriptencoding=utf-8

"" Colors
" http://vim.wikia.com/wiki/256_colors_in_vim
" configure terminal emulators to set $TERM properly
" install ncurses-term package to support custom terminals like putty-256color
syntax enable
set background=dark
let g:jellybeans_use_lowcolor_black = 0
colorscheme jellybeans  " https://github.com/nanotech/jellybeans.vim
highlight Comment ctermfg=darkgrey


"" General
set nonumber     " line numbers aren't needed
set ruler        " show the cursor position all the time
set showcmd      " show partial commands below the status line
set shell=bash   " avoids munging PATH under zsh
let g:is_bash=1  " default shell syntax
set history=200  " remember more Ex commands
set scrolloff=3  " have some context around the current line always on screen
set showmatch    " show matched braces
set matchpairs+=<:>  " show matched html tags
set wildmenu     " show wildmenu for menus
set wildcharm=<TAB>  " ... with autocomplete
set fileencodings=utf-8,windows-1251  " try to open file in valid encoding

"" Whitespace
set modeline        " read settings from edited files
set autoindent      " auto ident...
set smartindent     " ... based on current syntax
set tabstop=4       " a tab is four spaces
set softtabstop=4   " softtabstop equal to tabstop
set shiftwidth=4    " an autoindent (with <<) is four spaces
set expandtab       " use spaces, not tabs
set backspace=indent,eol,start   " backspace through everything in insert mode
set whichwrap=b,s,h,l,<,>,~,[,]  " allow to move cursor left and right to new line
vnoremap < <gv  " keep selection while using < to shift ident
vnoremap > >gv  " keep selection while using > to shift ident

"" Search
set hlsearch     " highlight matches
set incsearch    " incremental searching
set ignorecase   " searches are case insensitive...
set smartcase    " ... unless they contain at least one capital letter

"" Backup
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p", 0700)
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p", 0700)
endif

"" Dialogs
set confirm                " show dialogs insterad of error messages
set shortmess=fimnrxoOtTI  " use short dialogs
language POSIX             " use english for all messages

"" Binds (by default <leader> = \)
set pastetoggle=<F12>  " toggle paste mode

" remove DOS line endings (\r)
nnoremap <silent><leader>r :call RepairFile()<CR>

" read encoding menu
nnoremap <F8> :emenu File.Encoding.Read.<TAB>
inoremap <F8> <C-O>:emenu File.Encoding.Read.<TAB>
vnoremap <F8> <ESC>:emenu File.Encoding.Read.<TAB>

" write encoding menu
nnoremap <S-F8> :emenu File.Encoding.Write.<TAB>
inoremap <S-F8> <C-O>:emenu File.Encoding.Write.<TAB>
vnoremap <S-F8> <ESC>:emenu File.Encoding.Write.<TAB>


"" Cyrillic keyboard fix
set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,ё`,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,Ё~


if has("autocmd")

    " Enable file type detection.
    filetype plugin indent on
	
	" Smart daily backups
    autocmd! bufwritepre * call BackupDir()

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " Jump to the last known cursor position
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    augroup END

endif


"" Menu
if has("menu")

    " EOL
    anoremenu &File.&EOL.&unix :setlocal fileformat=unix fileformat?<CR>
    anoremenu &File.&EOL.&dos :setlocal fileformat=dos fileformat?<CR>
    anoremenu &File.&EOL.&mac :setlocal fileformat=mac fileformat?<CR>

    " Write encoding
    anoremenu &File.E&ncoding.&Write.&utf-8 :setlocal fileencoding=utf-8 fileencoding?<CR>
    anoremenu &File.E&ncoding.&Write.&windows-1251 :setlocal fileencoding=windows-1251 fileencoding?<CR>
    anoremenu &File.E&ncoding.&Write.&iso-8859-15 :setlocal fileencoding=iso-8859-15 fileencoding?<CR>
    anoremenu &File.E&ncoding.&Write.&koi8-r :setlocal fileencoding=koi8-r fileencoding?<CR>

    " Read encoding
    anoremenu &File.E&ncoding.&Read.&utf-8 :edit ++enc=utf-8<CR>:setlocal fileencoding?<CR>
    anoremenu &File.E&ncoding.&Read.&windows-1251 :edit ++enc=windows-1251<CR>:setlocal fileencoding?<CR>
    anoremenu &File.E&ncoding.&Read.&iso-8859-15 :edit ++enc=iso-8859-15<CR>:setlocal fileencoding?<CR>
    anoremenu &File.E&ncoding.&Read.&koi8-r :edit ++enc=koi8-r<CR>:setlocal fileencoding?<CR>

endif


"" Functions
if exists("*function")

    " Smart daily backups
    function! BackupDir()
            if !exists("g:backupdir_default")
                    let g:backupdir_default=&backupdir
            endif
            let l:backupdir=g:backupdir_default
            if &backup
                    if has("unix")
                            let l:backupdir.=substitute(expand("%:p:h"), "^".$HOME, "~", "")
                    else
                            let l:backupdir.=substitute(expand("%:p:h"), ":", "$", "")
                    endif
                    if !isdirectory(l:backupdir)
                            call mkdir(l:backupdir, "p", 0700)
                    endif
            endif
            let &backupdir=l:backupdir
            let &backupext=strftime("~%Y-%m-%d~")
    endfunction

    " Remove DOS line endings
    function! RepairFile()
        normal! mzHmy
        execute "%s/<C-V><C-M>$//ge"
        normal! 'yzt`z
        echo "DOS characters removed"
    endfunction

endif
