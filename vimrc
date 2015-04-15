set cursorline
set cursorcolumn
set laststatus=2
set cmdheight=2
set showmatch
set list

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
NeoBundle 'https://github.com/leafgarland/typescript-vim.git'
NeoBundle 'https://github.com/clausreinke/typescript-tools.git'
NeoBundle 'The-NERD-tree'
NeoBundle 'taglist.vim'
NeoBundle 'https://github.com/wesleyche/SrcExpl.git'
NeoBundle 'https://github.com/wesleyche/Trinity.git'
NeoBundle 'rhysd/accelerated-jk'
call neobundle#end()

NeoBundleCheck

filetype plugin indent on

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
imap <c-j> <esc>
