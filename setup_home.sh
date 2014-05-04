#!/bin/bash

install_dotfiles=true
dotfiles_url="https://github.com/jarijokinen/dotfiles.git"

code_path="$HOME/code"
dotfiles_path="$code_path/dotfiles"
dotfiles_installer_path="$dotfiles_path/install.sh"
git_path="/usr/bin/git"

if [ ! -e $code_path ]; then
  echo "Creating: $code_path"
  mkdir $code_path
fi

if [ $install_dotfiles ]; then
  if [ ! -e $dotfiles_path ]; then
    if [ ! -e $git_path ]; then
      echo "Missing: git"
      echo "Install: apt-get install git"
      exit 1
    fi

    echo "Installing: dotfiles"
    git clone $dotfiles_url $dotfiles_path
    cd $dotfiles_path
    git submodule init
    git submodule update
    `$dotfiles_installer_path`
  fi
fi

exit 0
