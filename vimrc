set autoindent
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
set t_Co=256

call pathogen#infect()
syntax on
filetype plugin indent on

colorscheme railscasts

autocmd BufNewFile,BufRead Gemfile setfiletype ruby
autocmd BufNewFile,BufRead *.pp setfiletype puppet

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetDirectories = ["ultisnips"]
