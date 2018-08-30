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
set shiftwidth=2
set showcmd
set smartindent
set softtabstop=2
set tabstop=2
set textwidth=0

if &term =~ "xterm.*"
  let &t_ti = &t_ti . "\e[?2004h"
  let &t_te = "\e[?2004l" . &t_te
  function! XTermPasteBegin(ret)
    set pastetoggle=<Esc>[201~
    set paste
    return a:ret
  endfunction
  map <expr> <Esc>[200~ XTermPasteBegin("i")
  imap <expr> <Esc>[200~ XTermPasteBegin("")
  vmap <expr> <Esc>[200~ XTermPasteBegin("c")
  cmap <Esc>[200~ <nop>
  cmap <Esc>[201~ <nop>
endif

colorscheme codedark

syntax on
filetype plugin indent on

let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetDirectories = ["ultisnips"]
