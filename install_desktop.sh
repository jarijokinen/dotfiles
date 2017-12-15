#!/bin/bash

dotfiles=(
  bashrc
  bin
  config
  gemrc
  gitconfig
  gitignore
  profile
  screenrc
  themes
  vimrc
)

set -e
msg() { echo "$1"; }
script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p $HOME/.config/xfce4/xfconf
mkdir -p $HOME/.themes

for dotfile in ${dotfiles[@]}; do
  src="$script_path/$dotfile"
  dst="$HOME/.$dotfile"
  cmd="cp -pr $src $dst"

  mkdir -p "$HOME/.backups"

  if [[ -e $dst ]]; then
    msg "[ backup  ] $dst"
    cp -pr "$dst" "$HOME/.backups/$(basename $dotfile)"
    rm -rf "$dst"
    msg "[ replace ] $dst"
    eval "$cmd"
  else
    msg "[ create  ] $dst"
    eval "$cmd"
  fi
done

cd $script_path
git submodule init
git submodule update

exit 0
