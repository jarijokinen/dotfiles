case $- in
  *i*) ;;
  *) return;;
esac

export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=YES
export EDITOR='vim'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export TERM='xterm-256color'
export PATH="$PATH:$HOME/bin"

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

git_branch() {
  git branch 2>> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="\u@\[\033[32m\]\w\[\033[33m\]\$(git_branch)\[\033[00m\]\$ " 
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
  PS1="\u@\h\[\033[32m\]\w\[\033[33m\]\$(git_branch)\[\033[00m\]\$ "
fi

PROMPT_DIRTRIM=3

if [[ -x /usr/bin/dircolors ]]; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

if [[ -x /usr/bin/lscpu ]]; then
  core_count=`lscpu | grep -i core | grep socket | rev | cut -d " " -f 1`
  alias make="make -j $core_count"
fi
