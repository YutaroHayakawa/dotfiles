set cursorline
set cursorcolumn
set laststatus=2
set cmdheight=2
set showmatch
set list

" This setting doesn't work on some platforms
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent
set smartindent
runtime ftplugin/man.vim

set number
autocmd ColorScheme * highlight Comment ctermfg=211 guifg=#008800
colorscheme molokai
syntax on

set nocompatible
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'The-NERD-tree'
NeoBundle 'taglist.vim'
NeoBundle 'https://github.com/wesleyche/SrcExpl.git'
NeoBundle 'https://github.com/wesleyche/Trinity.git'
NeoBundle 'rhysd/accelerated-jk'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'https://github.com/jceb/vim-orgmode.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/syntastic'
call neobundle#end()
NeoBundleCheck

filetype plugin indent on

"Syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"
"let g:syntastic_python_checkers = ['pyflakes', 'pep8']

" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction

" Shift + F で自動修正
autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>

"Custom key binds
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
imap <c-j> <esc>
