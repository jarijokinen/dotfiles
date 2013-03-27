set autoindent
set backspace=2
set directory=$HOME/.vim/swap
set encoding=utf-8
set expandtab
set laststatus=2
set nobackup
set nocompatible
set nowritebackup
set pastetoggle=<Ins>
set shiftwidth=2
set showcmd
set softtabstop=2
set tabstop=2
set textwidth=0
set t_Co=256

autocmd BufNewFile,BufRead Gemfile setlocal filetype=ruby

call pathogen#infect()
syntax on
filetype plugin indent on

colorscheme railscasts

autocmd User Rails Rnavcommand factory spec/factories
autocmd User Rails Rnavcommand outes config -default=routes
