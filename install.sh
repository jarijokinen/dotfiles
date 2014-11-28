#!/bin/bash

dotfiles=(
  bash_aliases
  bash_functions
  bashrc
  config/autostart/dropbox.desktop
  config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
  config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
  gemrc
  gitconfig
  gitignore
  kernel-pkg.conf
  muttrc
  profile
  railsrc
  screenrc
  vim
  vimrc
  Xresources
)

[[ -d $HOME/.config ]] || mkdir -p $HOME/.config
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

git submodule init
git submodule update

exit 0
