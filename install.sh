#!/bin/bash

dotfiles=(
  bash_functions
  bashrc
  bin
  gemrc
  gitconfig
  gitignore
  kernel-pkg.conf
  muttrc
  npmrc
  profile
  railsrc
  screenrc
  vim
  vimrc
  Xresources
)

set -e
msg() { echo "$1"; }
script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for dotfile in ${dotfiles[@]}; do
  src="$script_path/$dotfile"
  dst="$HOME/.$dotfile"
  cmd="ln -s $src $dst"

  if [[ -e $dst ]]; then
    if [[ -h $dst ]]; then
      if [[ $(readlink $dst) == $src ]]; then
        msg "[ skip    ] $dst"
      else
        msg "[ replace ] $dst"
        rm -rf "$dst"
        eval "$cmd"
      fi
    else
      msg "[ backup  ] $dst"
      mv "$dst" "$dst.backup"
      msg "[ replace ] $dst"
      eval "$cmd"
    fi
  else
    msg "[ create  ] $dst"
    eval "$cmd"
  fi
done

cd $script_path
git submodule init
git submodule update

exit 0
