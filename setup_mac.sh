#!/usr/bin/env bash

echo 'Installing dotfiles...'
f="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
install -m0600 -b "$f/Brewfile" "$HOME/Brewfile"
install -m0600 -b "$f/bashrc" "$HOME/.bashrc"
install -m0600 -b "$f/gitconfig" "$HOME/.gitconfig"
install -m0600 -b "$f/profile" "$HOME/.profile"
install -m0600 -b "$f/screenrc" "$HOME/.screenrc"
install -m0600 -b "$f/vimrc" "$HOME/.vimrc"

echo 'Setting keyboard repeat rate...'
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -float 1.8

echo 'Activating new settings...'
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo 'Installing Homebrew...'
/bin/bash -c "$(
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
)"
echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" >>"$HOME/.bashrc"
eval "$(/opt/homebrew/bin/brew shellenv)"

echo 'Installing Homebrew packages...'
brew bundle install --file="$HOME/Brewfile"

echo 'Changing default shell to bash...'
echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/bash
touch "$HOME/.hushlogin"

echo 'Installing Vim plugins...'
f=$HOME/.vim/pack/default/start
mkdir -p "$HOME/.vim/{swap,undo}"
mkdir -p "$f"
git clone https://github.com/vim-airline/vim-airline "$f/airline"
git clone --branch release https://github.com/neoclide/coc.nvim "$f/coc"
git clone https://github.com/tomasiser/vim-code-dark "$f/code-dark"
git clone https://github.com/dense-analysis/ale.git "$f/ale"

exit 0
