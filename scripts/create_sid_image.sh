#!/bin/bash
#
# create_sid_image.sh
# Copyright (C) 2018 Jari Jokinen. MIT License.
#
# This script creates a minimal system of Debian sid (unstable). The resulting
# image can be used as a base for desktop or server installations.

suite='sid'
version=$(date +'%Y-%m-%d-%s')
target=$HOME/$suite-$version
mirror='https://deb.debian.org/debian'
components='main,contrib,non-free'

packages='
  acpi-support-base
  console-setup
  grub-efi-amd64
  ifupdown
  irqbalance
  isc-dhcp-client
  kmod
  linux-image-amd64
  locales
  netbase
  systemd-sysv
  vim-nox
'

wifi_packages='
  dbus
  firmware-iwlwifi
  iwd
'

set -e
[[ $EUID -eq 0 ]] || (echo 'E: this script mus be run as root' && exit 1)

show_prompts() {
  read -ei $(hostname) -p "Hostname: " hostname
  read -sp 'Root password: ' root_password && echo

  echo 'Please choose a network type:'
  echo '1) Wi-Fi (default)'
  echo '2) Ethernet'
  read -p 'Network type: ' network_type

  case $network_type in
    2)
      network_type='ethernet'
      ;;
    *)
      network_type='wifi'
      read -p 'WPA SSID: ' ssid
      read -p 'WPA Password: ' psk
      ;;
  esac

  read -ei "en_US.UTF-8" -p "Locale: " locale
  read -ei "Europe/Helsinki" -p "Timezone: " timezone
  read -ei "fi" -p "Keyboard layout: " xkblayout
  read -ei "pc105" -p "Keyboard model: " xkbmodel
}

prepare_host() {
  echo 'Preparing the host system...'
  apt-get -qy install debootstrap
}

bootstrap_base_system() {
  echo 'Bootstrapping the base system...'
  packages=$(echo $packages | tr ' ' ,)
  debootstrap --merged-usr --variant=minbase --components=$components \
    --include=$packages $suite $target $mirror
}

prepare_chroot() {
  echo 'Preparing chroot environment...'
  mount --bind --make-rslave /dev $target/dev
  mount --bind --make-rslave /proc $target/proc
  mount --bind --make-rslave /sys $target/sys
}

set_hostname() {
  echo 'Setting hostname...'
  echo "$hostname" > $target/etc/hostname
}

set_root_password() {
  echo 'Setting root password...'
  echo "root:$root_password" | chroot $target chpasswd
}

configure_apt() {
  echo 'Configuring apt...'
  echo 'APT::Install-Recommends "0";' > $target/etc/apt/apt.conf.d/01recommends
  chroot $target apt-get -qy update
}

configure_locales() {
  echo 'Configuring locales...'
  echo "$locale UTF-8" > $target/etc/locale.gen
  echo "LANG='$locale'" > $target/etc/default/locale
  chroot $target locale-gen
}

configure_keyboard() {
  echo 'Configuring keyboard...'
  f=$target/etc/default/keyboard
  echo -e "XKBMODEL='$xkbmodel'\nXKBLAYOUT='$xkblayout'" > $f
  chroot $target dpkg-reconfigure -f noninteractive keyboard-configuration
}

configure_timezone() {
  echo 'Configuring timezone...'
  chroot $target ln -fs /usr/share/zoneinfo/$timezone /etc/localtime
  chroot $target dpkg-reconfigure -f noninteractive tzdata
}

configure_console() {
  echo 'Configuring console...'
  f=$target/etc/default/console-setup
  echo -e "CHARMAP='UTF-8'\nCODESET='guess'" > $f
  chroot $target dpkg-reconfigure -f noninteractive console-setup
}

configure_grub() {
  echo 'Configuring grub...'
  f=$target/etc/default/grub
  sed -i 's|GRUB_TIMEOUT=5|GRUB_TIMEOUT=1|g' $f
  sed -i 's|GRUB_CMDLINE_LINUX=""|GRUB_CMDLINE_LINUX="net.ifnames=0"|g' $f
}

configure_networking() {
  echo 'Configuring networking...'
  if [[ $network_type == 'wifi' ]]; then
    chroot $target apt-get -qy install $wifi_packages
    echo -e "auto wlan0\niface wlan0 inet dhcp\nwpa-ssid $ssid\nwpa-psk $psk" \
      > $target/etc/network/interfaces.d/wlan0
    chmod 600 $target/etc/network/interfaces.d/wlan0
  else
    echo -e "auto eth0\niface eth0 inet dhcp" \
      > $target/etc/network/interfaces.d/eth0
  fi
}

install_setup_scripts() {
  echo 'Installing setup scripts...'
  
  cat <<-'EOF' > $target/setup_disks.sh
	#!/bin/bash
	set -e
	uuid_efi=$(blkid /dev/sda1 -s UUID -o value)
	uuid_root=$(blkid /dev/sda2 -s UUID -o value)
	uuid_swap=$(blkid /dev/sda3 -s UUID -o value)
	echo "UUID=$uuid_root / ext4 defaults 0 1" > /etc/fstab
	echo "UUID=$uuid_efi /boot/efi vfat umask=0077 0 1" >> /etc/fstab
	echo "UUID=$uuid_swap none swap defaults 0 0" >> /etc/fstab
	mkdir /boot/efi
	mount /dev/sda1 /boot/efi
	/usr/sbin/grub-install /dev/sda
	/usr/sbin/update-grub
	exit 0
	EOF

  cat <<-'EOF' > $target/setup_image.sh
	#!/bin/sh
	set -e
	mount --bind --make-rslave /dev ./dev
	mount --bind --make-rslave /proc ./proc
	mount --bind --make-rslave /sys ./sys
	chroot . /setup_disks.sh
	exit 0
	EOF

  chmod 700 $target/*.sh
}

clean_packages() {
  echo 'Cleaning packages...'
  chroot $target apt-get clean
}

finish_chroot() {
  echo 'Finish chroot environment...'
  umount -l $target/dev
  umount -l $target/proc
  umount -l $target/sys
}

show_prompts
prepare_host
bootstrap_base_system
prepare_chroot
set_hostname
set_root_password
configure_apt
configure_locales
configure_keyboard
configure_timezone
configure_console
configure_grub
configure_networking
install_setup_scripts
clean_packages
finish_chroot

exit 0
