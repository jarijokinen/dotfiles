#!/bin/bash

dotfiles=(
  bash_functions
  bashrc
  bin
  config/xfce4/xfconf/xfce-perchannel-xml
  gemrc
  gitconfig
  gitignore
  kernel-pkg.conf
  muttrc
  profile
  railsrc
  screenrc
  themes/axiomd
  vim
  vimrc
  Xresources
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

  if [[ -e $dst ]]; then
    msg "[ backup  ] $dst"
    mv "$dst" "$dst.backup"
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
