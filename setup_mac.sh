#!/bin/bash

set -e

MODEL=$(system_profiler SPHardwareDataType | awk -F': ' '/Model Name/ { print $2 }')

echo 'Changing default shell to bash...'
chsh -s /bin/bash
touch $HOME/.hushlogin

echo 'Setting keyboard repeat rate...'
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -float 1.8

if [[ "$MODEL" == 'MacBook Air' ]]; then
  echo 'Setting trackpad scaling...'
  defaults write -g com.apple.trackpad.scaling -float 0.875
fi

echo 'Activating new settings...'
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo 'Setting defaults for Terminal...'
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"
/usr/libexec/PlistBuddy -c "Set :'Window Settings':'Pro':shellExitAction 1" ~/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Add :'Window Settings':'Pro':Bell bool false" ~/Library/Preferences/com.apple.Terminal.plist

echo 'Installing Vim plugins...'
f=$HOME/.vim/pack/default/start
mkdir -p $f
mkdir -p $HOME/.vim/swap
git clone https://github.com/vim-airline/vim-airline $f/airline
git clone --branch release https://github.com/neoclide/coc.nvim $f/coc
git clone https://github.com/tomasiser/vim-code-dark $f/code-dark
git clone https://github.com/tpope/vim-commentary $f/commentary
git clone https://github.com/github/copilot.vim $f/copilot
git clone https://github.com/sheerun/vim-polyglot $f/polyglot

echo 'Installing dotfiles...'
f="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
install -m0600 -b $f/bashrc $HOME/.bashrc
install -m0600 -b $f/gitconfig $HOME/.gitconfig
install -m0600 -b $f/prettierrc $HOME/.prettierrc
install -m0600 -b $f/profile $HOME/.profile
install -m0600 -b $f/screenrc $HOME/.screenrc
install -m0600 -b $f/vimrc $HOME/.vimrc
cp -pr $f/vim/* $HOME/.vim/

echo 'Installing Homebrew...'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.bashrc
eval "$(/opt/homebrew/bin/brew shellenv)"

echo 'Installing Homebrew packages...'
brew tap hashicorp/tap
brew install \
  adobe-creative-cloud \
  awscli \
  bash \
  canva \
  codex \
  figma \
  git \
  google-chrome \
  hashicorp/tap/terraform \
  node \
  screen \
  trader-workstation \
  tradingview \
  vim \
  wget \
  winbox \
  wireshark-app

exit 0
