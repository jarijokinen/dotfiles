case $- in
  *i*) ;;
  *) return;;
esac

export EDITOR='vim'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export TERM='xterm-256color'

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
  xterm*)
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

if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
  source /etc/bash_completion
fi


core_count=`lscpu | grep -i core | grep socket | rev | cut -d " " -f 1`
alias make="make -j $core_count"
