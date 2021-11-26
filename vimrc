set autoindent
set background=dark
set backspace=2
set cmdheight=2
set directory=~/.vim/swap
set encoding=utf-8
set expandtab
set hidden
set laststatus=2
set nobackup
set nocompatible
set nowritebackup
set number
set pastetoggle=<Ins>
set shiftwidth=2
set shortmess+=c
set showcmd
set signcolumn=number
set smartindent
set softtabstop=2
set tabstop=2
set textwidth=0
set updatetime=300

colorscheme codedark

syntax on
filetype plugin indent on

" coc.nvim

let g:coc_global_extensions = [
  \ 'coc-clangd',
  \ 'coc-cmake',
  \ 'coc-css',
  \ 'coc-cssmodules',
  \ 'coc-emmet',
  \ 'coc-eslint',
  \ 'coc-flutter',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-yaml'
  \ ]

nmap <silent> ,d <Plug>(coc-definition)
nmap <silent> ,y <Plug>(coc-type-definition)
nmap <silent> ,i <Plug>(coc-implementation)
nmap <silent> ,r <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap ,rn <Plug>(coc-rename)
nmap ,f <Plug>(coc-format-selected)
xmap ,f <Plug>(coc-format-selected)
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

autocmd CursorHold * silent call CocActionAsync('highlight')
