function clone {
  if [[ "$1" == *://* ]]; then
    git clone $1
  elif [[ "$1" == */* ]]; then
    git clone git://github.com/$1.git
  else
    git clone git@github.com:jarijokinen/$1.git
  fi
}
function push {
  git push origin master
}
function pull {
  git pull
}
function clean {
  echo -n "Delete swap files... "
  find $HOME/.vim/swap -maxdepth 1 -type f -mtime +2 -name "*.s??" -delete
  echo "OK."

  echo -n "Set permissions... "
  find $HOME -maxdepth 1 -type f -print0 | xargs -0 chmod 600
  find $HOME -maxdepth 1 -type d -print0 | xargs -0 chmod 700
  chmod 700 $HOME
  echo "OK."

  echo -n "Create symlinks... "
  rm -f $HOME/.xsession-errors
  ln -s /dev/null $HOME/.xsession-errors
  echo "OK."
}
function update {
  su -c 'apt-get update; apt-get dist-upgrade'
  rvm get stable
  gem update --system
  gem update
  cd $HOME/code/dotfiles
  git submodule foreach git pull origin master
}
function update_kernel {
  src=$HOME/src

  mainline_url=$(
    curl -s https://kernel.org | grep "Download complete" | head -1 \
    | grep -oP 'https://.+?xz'
  )
  mainline_version=$(echo ${mainline_url##*/} | cut -d . -f -2)
  mainline_archive="$mainline_version.tar.xz"
  echo "Latest mainline kernel is $mainline_version"

  if [[ ! -d $src/$mainline_version ]]; then
    echo "Kernel source missing, fetching..."
    if [[ ! -f $src/$mainline_archive ]]; then
      echo "Kernel archive missing, downloading..."
      mkdir -p $src
      wget $mainline_url -O $src/$mainline_archive
    fi
    tar -xvf $src/$mainline_archive -C $src
  fi

  cd $src/$mainline_version
  cp /boot/config-`uname -r` ./.config
  make silentoldconfig
  make-kpkg --rootcmd fakeroot --revision 1 --initrd kernel_image
}
