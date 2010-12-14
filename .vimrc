source $VIMRUNTIME/mswin.vim
behave mswin

set encoding=utf-8
set nocompatible
set nobackup
set backspace=2
set pastetoggle=<Ins>
set noinsertmode
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set textwidth=0
set ruler
set gfn=Terminus\ 12
set guioptions-=T

syntax enable
colorscheme railscasts

nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-right> :tabnext<CR>
nnoremap <silent> <C-left> :tabprevious<CR>

set fdm=marker
set fmr={{{,}}}

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype off
filetype plugin indent on

autocmd User Rails  Rnavcommand outes config -default=routes
autocmd User Rails  map <buffer> <F1> <esc>:Rdoc<CR>
