function clone {
  if [[ "$1" == *://* ]]; then
    git clone $1
  elif [[ "$1" == */* ]]; then
    git clone git://github.com/$1.git
  else
    git clone git@github.com:jarijokinen/$1.git
  fi
}
function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/:\1/'
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
