#!/bin/bash

set -e

install_vim_plugins() {
  echo 'Installing Vim plugins...'
  f=$HOME/.vim/pack/default/start
  mkdir -p $f
  mkdir -p $HOME/.vim/swap
  git clone https://github.com/tomasiser/vim-code-dark $f/code-dark
  git clone https://github.com/vim-airline/vim-airline $f/airline
  git clone https://github.com/sheerun/vim-polyglot $f/polyglot
  git clone https://github.com/tpope/vim-rails $f/rails
  git clone https://github.com/SirVer/ultisnips $f/ultisnips
}

install_dotfiles() {
  echo 'Installing dotfiles...'
	script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	install -m0600 -b -T $script_path/bashrc $HOME/.bashrc
	install -m0700 -b -d $script_path/config $HOME/.config
	install -m0600 -b -T $script_path/profile $HOME/.profile
	install -m0600 -b -T $script_path/screenrc $HOME/.screenrc
	install -m0700 -b -d $script_path/themes $HOME/.themes
	install -m0600 -b -T $script_path/vimrc $HOME/.vimrc
}

install_vim_plugins
install_dotfiles

exit 0
