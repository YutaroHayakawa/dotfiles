set cursorline
set cursorcolumn
set laststatus=2
set cmdheight=2
set showmatch
set list

" This setting doesn't work on some platforms
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

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
NeoBundle 'The-NERD-tree'
NeoBundle 'taglist.vim'
NeoBundle 'https://github.com/wesleyche/SrcExpl.git'
NeoBundle 'https://github.com/wesleyche/Trinity.git'
NeoBundle 'rhysd/accelerated-jk'
NeoBundle 'thinca/vim-quickrun'
call neobundle#end()
NeoBundleCheck

filetype plugin indent on

"Custom key binds
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
imap <c-j> <esc>
