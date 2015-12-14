case $- in
  *i*) 
    ;;
  *)
    return
    ;;
esac

if [[ -f  ~/.bash_functions ]]; then
  source ~/.bash_functions
fi

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='${debian_chroot:+($debian_chroot)}\u@\H:\w\$ '

case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\H: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

if [[ -x /usr/bin/dircolors ]]; then
  test -r ~/.dircolors && 
  eval "$(dircolors -b ~/.dircolors)" || 
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

if [[ -f ~/.bash_aliases ]]; then
  source ~/.bash_aliases
fi

if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export EDITOR='vim'
export PATH="$PATH:$HOME/.rvm/bin"

if [[ "$DISPLAY" ]]; then
  synclient FingerLow=10
  synclient FingerHigh=16
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
