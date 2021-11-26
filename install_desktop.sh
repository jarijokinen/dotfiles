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
install -m0600 -b -T $script_path/bashrc $HOME/.bashrc
install -m0600 -b -T $script_path/gemrc $HOME/.gemrc
install -m0600 -b -T $script_path/gitconfig $HOME/.gitconfig
install -m0600 -b -T $script_path/prettierrc $HOME/.prettierrc
install -m0600 -b -T $script_path/profile $HOME/.profile
install -m0600 -b -T $script_path/screenrc $HOME/.screenrc
install -m0600 -b -T $script_path/vimrc $HOME/.vimrc
cp -pr $script_path/bin $HOME/bin
cp -pr $script_path/config $HOME/.config
cp -pr $script_path/themes $HOME/.themes
cp -pr $script_path/vim/* $HOME/.vim/

echo 'Changing Downloads directory location...'
mkdir -p $HOME/Dropbox/Downloads
mv $HOME/Downloads/* $HOME/Dropbox/Downloads/
rm -rf $HOME/Downloads
ln -s $HOME/Dropbox/Downloads $HOME/Downloads

exit 0
