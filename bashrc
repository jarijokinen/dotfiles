case $- in
  *i*) ;;
  *) return;;
esac

export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1
export EDITOR=vim
export PATH="$HOME/.local/bin:$PATH"

HISTCONTROL=ignoreboth:erasedups
HISTFILESIZE=20000
HISTSIZE=10000

shopt -s histappend

git_branch() {
  local branch
  branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || return
  printf '(%s)' "$branch"
}

PROMPT_DIRTRIM=3
PS1="\u@\[\033[32m\]\w\[\033[33m\]\$(git_branch)\[\033[00m\]\$ "
if [[ -n "$SSH_CONNECTION" ]]; then
  PS1="\u@\h\[\033[32m\]\w\[\033[33m\]\$(git_branch)\[\033[00m\]\$ "
fi

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

if [[ "$OSTYPE" == linux* ]]; then
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi
