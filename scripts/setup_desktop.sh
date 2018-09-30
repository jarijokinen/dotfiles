#!/bin/bash
#
# setup_desktop.sh
# Copyright (C) 2018 Jari Jokinen. MIT License.
#
# This script sets up a desktop environment on base installation of Debian sid.

packages='
  autoconf
  automake
  curl
  dbus-x11
  dialog
  gdb
  gimp
  git
  gnupg2
  ht
  hugo
  info
  inkscape
  keepassx
  kernel-package
  less
  libssl-dev
  libtool
  lightdm
  lsb-release
  m4
  man
  nasm
  nautilus-dropbox
  openssh-client
  pavucontrol
  pkg-config
  policykit-1
  pulseaudio
  python3-pip
  python3-setuptools
  qemu-utils
  qemu-system-gui
  qemu-system-x86
  radare2
  rng-tools
  screen
  software-properties-common
  ttf-mscorefonts-installer
  vim-nox
  wget
  whois
  x11-xserver-utils
  xdg-utils
  xfce4-battery-plugin
  xfce4-panel
  xfce4-pulseaudio-plugin
  xfce4-screenshooter
  xfce4-session
  xfdesktop4
  xfonts-100dpi
  xfonts-scalable
  xfonts-terminus
  xfwm4
  xserver-xorg
  xserver-xorg-input-libinput
  xserver-xorg-input-synaptics
  xserver-xorg-video-intel
  xterm
'

npm_packages='
  @angular/cli
  create-react-app
  create-react-native-app
  eslint
  firebase-tools
  gatsby-cli
  gulp-cli
  npm-check-updates
  react-native-cli
'

pip_packages='
  awscli
'

set -e
[[ $EUID -eq 0 ]] || (echo 'E: this script mus be run as root' && exit 1)

show_prompts() {
  echo 'Creating a regular user account...'
  read -p "Username: " username
  read -sp "Password: " user_password && echo
  adduser $username -q --gecos ',,,' --disabled-password
  echo "$username:$user_password" | chpasswd
}

install_packages() {
  echo 'Installing packages...'
  apt-get -qy install $packages
}

install_chrome() {
  echo 'Installing Google Chrome...'
  tmpfile='/tmp/chrome.deb'
  url='https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
  wget -q -O $tmpfile $url
  apt-get -qy install fonts-liberation libappindicator3-1 libdbusmenu-gtk3-4 \
    libdbusmenu-glib4
  dpkg -i $tmpfile
}

install_nodejs() {
  echo 'Installing Node.js...'
  curl -sL https://deb.nodesource.com/setup_10.x | bash -
  apt-get -qy install nodejs
}

install_npm_packages() {
  echo 'Installing Node packages...'
  npm install -g $npm_packages
}

install_pip_packages() {
  echo 'Installing Python packages...'
  pip3 install $pip_packages
}

install_watchman() {
  echo 'Installing Watchman...'
  git clone https://github.com/facebook/watchman.git /tmp/watchman
  cd /tmp/watchman
  git checkout v4.9.0
  ./autogen.sh
  ./configure --without-pcre --without-python --enable-lenient
  make
  make install
}

install_android_studio() {
  echo 'Installing Android Studio...'
  package_url=$(
    curl -s https://developer.android.com/studio/ |
    grep -oP https.+?linux.zip | head -1
  )
  wget $package_url -O /tmp/android-studio.zip
  unzip /tmp/android-studio.zip -d /opt
  usermod -aG plugdev $username

  cat <<-"EOF" >> /etc/udev/rules.d/51-android.rules
		SUBSYSTEM=="usb", ATTR{idProduct}=="4ee7", MODE="0660", GROUP="plugdev", SYMLINK+="android%n"
	EOF
}

install_docker() {
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
  apt-get -qy update
  apt-get -qy install docker-ce docker-compose
  usermod -aG docker $username
}

show_prompts
install_packages
install_chrome
install_nodejs
install_npm_packages
install_pip_packages
install_watchman
install_android_studio
install_docker

exit 0
