#!/bin/bash

set -e

echo 'Installing Vim plugins...'
f=$HOME/.vim/pack/default/start
mkdir -p $f
mkdir -p $HOME/.vim/swap
git clone https://github.com/vim-airline/vim-airline $f/airline
git clone -b release https://github.com/neoclide/coc.nvim $f/coc
git clone https://github.com/tomasiser/vim-code-dark $f/code-dark
git clone https://github.com/tpope/vim-commentary $f/commentary
git clone https://github.com/mattn/emmet-vim $f/emmet
git clone https://github.com/sheerun/vim-polyglot $f/polyglot
git clone https://github.com/tpope/vim-rails $f/rails
git clone https://github.com/tpope/vim-surround $f/surround

echo 'Installing dotfiles...'
script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
install -m0600 -b $script_path/bashrc $HOME/.bashrc
install -m0600 -b $script_path/gemrc $HOME/.gemrc
install -m0600 -b $script_path/gitconfig $HOME/.gitconfig
install -m0600 -b $script_path/prettierrc $HOME/.prettierrc
install -m0600 -b $script_path/profile $HOME/.profile
install -m0600 -b $script_path/screenrc $HOME/.screenrc
install -m0600 -b $script_path/vimrc $HOME/.vimrc
cp -pr $script_path/bin $HOME/bin
cp -pr $script_path/vim/* $HOME/.vim/

touch $HOME/.hushlogin

$HOME/bin/install_homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install \
  android-studio \
  bash \
  coreutils \
  figma \
  dropbox \
  git \
  messenger \
  screen \
  slack \
  vim \
  wget

exit 0
