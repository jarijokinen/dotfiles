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

colorscheme codedark

autocmd BufNewFile,BufRead *.php setlocal filetype=php.html
autocmd BufNewFile,BufRead *.vue setlocal filetype=html.javascript.css.vue

map <C-n> :NERDTreeToggle<CR>

let g:jsx_ext_required = 0
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetDirectories = ["ultisnips"]
