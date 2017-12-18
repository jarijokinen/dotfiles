#!/bin/bash

dotfiles=(
  config
  themes
)

set -e
script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p $HOME/.config/xfce4/xfconf
mkdir -p $HOME/.themes

for dotfile in ${dotfiles[@]}; do
  src="$script_path/$dotfile"
  dst="$HOME/.$dotfile"
  cmd="cp -pr $src $dst"

  mkdir -p "$HOME/.backups"

  if [[ -e $dst ]]; then
    echo "[ backup  ] $dst"
    cp -pr "$dst" "$HOME/.backups/$(basename $dotfile)"
    rm -rf "$dst"
    echo "[ replace ] $dst"
    eval "$cmd"
  else
    echo "[ create  ] $dst"
    eval "$cmd"
  fi
done

exit 0
