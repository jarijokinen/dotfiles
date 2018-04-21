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

echo 'Adding user to docker group...'
su -c "adduser $USER docker"

echo 'Installing Google Fonts...'
wget https://github.com/google/fonts/archive/master.zip -O /tmp/gfonts.zip
mkdir $HOME/.fonts
unzip /tmp/gfonts.zip -d $HOME/.fonts
fc-cache

echo 'Installing Vim plugins...'
f="$HOME/.vim/pack/default/start"
mkdir -p $f
mkdir -p $HOME/.vim/swap
git clone https://github.com/jpo/vim-railscasts-theme $f/railscasts
git clone https://github.com/sheerun/vim-polyglot $f/polyglot
git clone https://github.com/tpope/vim-rails $f/rails
git clone https://github.com/SirVer/ultisnips $f/ultisnips
git clone https://github.com/vim-airline/vim-airline $f/airline
git clone https://github.com/scrooloose/nerdtree $f/nerdtree
git clone https://github.com/tomasiser/vim-code-dark $f/code-dark

echo 'Installing Python...'
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
cat <<'EOF' >> $HOME/.bashrc
export PATH="/home/jari/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF
export PATH="/home/jari/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv update
pyenv install 3.6.5
pyenv global 3.6.5
pip install -U pip

echo 'Installing AWS CLI...'
pip install awscli

echo 'Installing Firebase CLI...'
npm install -g firebase-tools

echo 'Installing Node...'
curl -L https://git.io/n-install | bash
export PATH="$PATH:$HOME/n/bin"

echo 'Installing Vue.js...'
yarn global add vue-cli

echo 'Installing Angular...'
yarn global add @angular/cli

echo 'Installing Ionic...'
yarn global add cordova ionic

echo 'Installing React...'
yarn global add react-native-cli
yarn global add create-react-app
yarn global add create-react-native-app

echo 'Installing RVM...'
gpg --keyserver hkp://keys.gnupg.net \
  --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
  7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s head --autolibs=read-fail
cat <<'EOF' >> $HOME/.bashrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
EOF
source $HOME/.rvm/scripts/rvm

echo 'Installing Ruby...'
rvm install ruby
gem update --system
gem update

echo 'Installing Rails...'
gem install rails

echo 'Installing Android Studio...'
package_url=$(
  curl -s https://developer.android.com/studio/index.html | 
  grep -oP https.+?linux.zip | head -1
)
wget $package_url -O /tmp/android-studio.zip
unzip /tmp/android-studio.zip -d $HOME
cat <<'EOF' >> $HOME/.bashrc
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
EOF
su -c 'cat <<"EOF" >> /etc/udev/rules.d/51-anrdoid.rules
SUBSYSTEM=="usb", ATTR{idProduct}=="4ee7", MODE="0660", GROUP="plugdev", SYMLINK+="android%n"
EOF'
su -c "usermod -aG plugdev $USER"

exit 0
