#!/bin/bash

install_ruby=true
install_dotfiles=true
ruby_version="ruby-2.0.0"
dotfiles_url="https://github.com/jarijokinen/dotfiles.git"
rvm_url="https://get.rvm.io"

code_path="$HOME/code"
dotfiles_path="$code_path/dotfiles"
dotfiles_installer_path="$dotfiles_path/install.sh"
rvm_path="$HOME/.rvm"
git_path="/usr/bin/git"
curl_path="/usr/bin/curl"

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

if [ $install_ruby ]; then
  if [ ! -e $curl_path ]; then
    echo "Missing: curl"
    echo "Install: apt-get install curl"
    exit 1
  fi

  if [ ! -e $rvm_path/bin/rvm ]; then
    echo "Installing: rvm"
    \curl -L $rvm_url | bash -s stable --autolibs=disabled
  fi

  source $HOME/.rvm/scripts/rvm

  echo "Installing: $ruby_version"
  rvm install $ruby_version
  rvm use $ruby_version --default
fi

exit 0
