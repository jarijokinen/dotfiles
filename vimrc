set autoindent
set background=dark
set backspace=indent,eol,start
set cmdheight=2
set directory=~/.vim/swap//
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nobackup
set nowritebackup
set number
set scrolloff=5
set shiftwidth=2
set showcmd
set signcolumn=number
set smartcase
set softtabstop=2
set tabstop=2
set undodir=~/.vim/undo//
set undofile
set updatetime=300

colorscheme codedark

syntax on
filetype plugin indent on

let mapleader = " " 

nnoremap <silent> <Esc> :nohlsearch<CR>

let g:coc_global_extensions = [ 
  \ 'coc-clangd',
  \ 'coc-cmake',
  \ 'coc-css',
  \ 'coc-cssmodules',
  \ 'coc-eslint',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-tsserver',
  \ 'coc-yaml'
\ ]

let g:coc_user_config = {
\   'inlayHint.enable': v:false,
\   'diagnostic.displayByAle': v:true
\ }

nmap <silent> ,d <Plug>(coc-definition)
nmap <silent> ,y <Plug>(coc-type-definition)
nmap <silent> ,i <Plug>(coc-implementation)
nmap <silent> ,r <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> ,rn <Plug>(coc-rename)
nmap <silent> ,f <Plug>(coc-format-selected)
xmap <silent> ,f <Plug>(coc-format-selected)

let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'javascript':       ['eslint'],
\   'javascriptreact':  ['eslint'],
\   'typescript':       ['eslint'],
\   'typescriptreact':  ['eslint'],
\   'python':           ['ruff'],
\   'css':              ['stylelint'],
\   'scss':             ['stylelint'],
\   'sh':               ['shellcheck'],
\   'bash':             ['shellcheck']
\}
let g:ale_fixers = {
\   'javascript':       ['prettier', 'eslint'],
\   'javascriptreact':  ['prettier'],
\   'typescript':       ['prettier'],
\   'typescriptreact':  ['prettier'],
\   'json':             ['prettier'],
\   'jsonc':            ['prettier'],
\   'css':              ['prettier'],
\   'scss':             ['prettier'],
\   'html':             ['prettier'],
\   'yaml':             ['prettier'],
\   'markdown':         ['prettier'],
\   'python':           ['ruff_format'],
\   'sh':               ['shfmt'],
\   'bash':             ['shfmt']
\}
let g:ale_lint_delay = 500
let g:ale_set_signs = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_info = 'ii'
let g:ale_echo_cursor = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
nmap <silent> <leader>f <Plug>(ale_fix)
nnoremap <silent> <leader>d :ALEDetail<CR>
nnoremap <silent> <leader>l :lopen<CR>
nnoremap <silent> <leader>c :ALELint<CR>
nnoremap <silent> <leader>a :ALEToggle<CR>
