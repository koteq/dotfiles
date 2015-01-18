set nocompatible
scriptencoding=utf-8

"" Binds
" F8 - file read encoding menu
" S-F8 - file write encoding menu
"
" <leader> - mapped to \
" <leader>r - remove DOS \r line endings

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

"" Auto toggle paste mode
if exists("*function")
    let &t_SI .= "\<Esc>[?2004h"
    let &t_EI .= "\<Esc>[?2004l"

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

    function! XTermPasteBegin()
      set pastetoggle=<Esc>[201~
      set paste
      return ""
    endfunction
endif

" Remove DOS line endings (\r)
if exists("*function")
    nnoremap <silent><leader>r :call RepairFile()<CR>

    function! RepairFile()
        normal! mzHmy
        execute "%s/<C-V><C-M>$//ge"
        normal! 'yzt`z
        echo "DOS characters removed"
    endfunction
endif

" Read encoding menu
nnoremap <F8> :emenu File.Encoding.Read.<TAB>
inoremap <F8> <C-O>:emenu File.Encoding.Read.<TAB>
vnoremap <F8> <ESC>:emenu File.Encoding.Read.<TAB>

" Write encoding menu
nnoremap <S-F8> :emenu File.Encoding.Write.<TAB>
inoremap <S-F8> <C-O>:emenu File.Encoding.Write.<TAB>
vnoremap <S-F8> <ESC>:emenu File.Encoding.Write.<TAB>

"" Status line
set noruler
set laststatus=2
hi StatusLine ctermbg=0 ctermfg=7

if exists("*function")
    " Add the variable with the name a:varName to the statusline. Highlight it as
    " 'error' unless its value is in a:goodValues (a comma separated string)
    function! AddStatuslineFlag(varName, goodValues)
        set statusline+=[
        set statusline+=%#error#
        exec "set statusline+=%{RenderStlFlag(".a:varName.",'".a:goodValues."',1)}"
        set statusline+=%*
        exec "set statusline+=%{RenderStlFlag(".a:varName.",'".a:goodValues."',0)}"
        set statusline+=]
    endfunction

    function! RenderStlFlag(value, goodValues, error)
        let goodValues = split(a:goodValues, ',')
        let good = index(goodValues, a:value) != -1
        if (a:error && !good) || (!a:error && good)
            return a:value
        else
            return ''
        endif
    endfunction
endif

set statusline=%t\      " tail of the filename
set statusline+=%m      " modified flag
if exists("*function")
    call AddStatuslineFlag('&ff', 'unix')    " fileformat
    call AddStatuslineFlag('&fenc', 'utf-8') " file encoding
else
    set statusline+=[%{&ff}]                        " fileformat
    set statusline+=[%{strlen(&fenc)?&fenc:'none'}] " file encoding
endif
set statusline+=%y      " filetype
set statusline+=%r      " read only flag
set statusline+=%=      " left/right separator
set statusline+=&#%B;\  " char code
set statusline+=%c,     " cursor column
set statusline+=%l/%L   " cursor line/total lines
set statusline+=\ %P    " percent through file

"" Cyrillic keyboard fix
set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,ё`,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,Ё~

" Autocmd settings
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
    
endif
