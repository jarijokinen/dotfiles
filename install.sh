#!/bin/bash

dotfiles=(
  bash_aliases
  bash_functions
  bashrc
  config/xfce4
  config/user-dirs.dirs
  config/user-dirs.locale
  gemrc
  gitconfig
  gitignore
  Guardfile
  muttrc
  profile
  railsrc
  screenrc
  rspec
  vim
  vimrc
  Xresources
)

script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for dotfile in ${dotfiles[@]}; do
  src="$script_path/$dotfile"
  dst="$HOME/.$dotfile"
  cmd="ln -s $src $dst"

  if [ -e $dst ]; then
    if [ -h $dst ]; then
      if [ $(readlink $dst) == "$src" ]; then
        echo "[ skip    ] $dst"
        continue
      else
        echo "[ replace ] $dst"
        `rm -rf $dst`
        `$cmd`
        continue
      fi
    else
      echo "[ backup  ] $dst"
      backup_cmd="mv $dst $dst.backup"
      `$backup_cmd`
      echo "[ replace ] $dst"
      `$cmd`
      continue
    fi
  else
    echo "[ create  ] $dst"
    `$cmd`
  fi
done

exit 0
