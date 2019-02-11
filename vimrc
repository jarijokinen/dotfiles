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
set smartindent
set softtabstop=2
set tabstop=2
set textwidth=0

colorscheme codedark

syntax on
filetype plugin indent on

au BufNewFile,BufRead *.php set filetype=php.html

let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetDirectories = ["ultisnips"]
