#!/bin/bash
#
# setup_desktop.sh
# Copyright (C) 2018 Jari Jokinen. MIT License.
#
# This script sets up a desktop environment on base installation of Debian sid.

packages='
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
  lightdm
  lsb-release
  man
  nasm
  nautilus-dropbox
  openssh-client
  pavucontrol
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
  create-react-native-app
  firebase-tools
  gulp-cli
  npm-check-updates
'

pip_packages='
  awscli
'

set -e
[[ $EUID -eq 0 ]] || (echo 'E: this script mus be run as root' && exit 1)

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
  curl -sL https://deb.nodesource.com/setup_10.x | bash -
  apt-get -qy install nodejs
}

install_npm_packages() {
  npm install -g $npm_packages
}

install_pip_packages() {
  pip3 install $pip_packages
}

install_packages
install_chrome
install_nodejs
install_npm_packages
install_pip_packages

exit 0
