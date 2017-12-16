set autoindent
set background=dark
set backspace=2
set directory=~/.vim/swap
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

syntax on
filetype plugin indent on

colorscheme railscasts

autocmd BufNewFile,BufRead Gemfile setfiletype ruby
autocmd BufNewFile,BufRead *.php set filetype=html
autocmd BufNewFile,BufRead *.php set syntax=php
autocmd BufNewFile,BufRead *.scss set filetype=css
autocmd BufNewFile,BufRead *.scss set syntax=scss

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetDirectories = ["ultisnips"]
