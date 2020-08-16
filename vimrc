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


" My default preference, may overridden by other coding styles
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

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
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

"
" Dein plugin settings
"

" Deoplete.vim
call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
let g:deoplete#enable_at_startup = 1

" vim-polyglot
call dein#add('sheerun/vim-polyglot')

" deoplete-jedi
call dein#add('deoplete-plugins/deoplete-jedi')

"
" Settings needed to be at last
"
syntax enable
filetype plugin indent on
