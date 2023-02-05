"
" Basic settings
"
set nocompatible
set cursorline
set cursorcolumn
set laststatus=2
set cmdheight=2
set backspace=2
set showmatch
set autoindent
set smartindent
set list
set number
set termguicolors
set completeopt+=noinsert,menuone


" My default preference, may overridden by other coding styles
set tabstop=4
set shiftwidth=4
set softtabstop=4

autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Some plugins needs python to work, to avoid the conflict with venvs, set
" absolute python path. This setting depends on the pyenv
let g:python_host_prog='~/.pyenv/versions/vim/bin/python'
let g:python3_host_prog='~/.pyenv/versions/vim/bin/python3'

"
" Color scheme
"

" Default comment color of the monokai_pro is invisible in transparent screen
autocmd ColorScheme * highlight Comment ctermfg=211 guifg=#EA9198
" colorscheme molokai
colorscheme monokai_pro

"
" Custom key bind
"

" Map Ctrl-j to Esc
imap <c-j> <esc>

"
" Dein basic settings
"

" Took from official README
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('fatih/vim-go')

  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

"
" Settings needed to be at last
"
syntax enable
filetype plugin indent on
