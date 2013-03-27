[ -z "$PS1" ] && return

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ `hostname` == "laptop" ] && [ "$LOGNAME" == "jari" ]; then
    PS1='\w$(git_branch)\$ '
    xterm_title="\[\e]0;\w\$(git_branch)\a\]$PS1"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

case "$TERM" in
    xterm*|rxvt*)
        PS1=$xterm_title
        ;;
    *)
        ;;
esac

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -e /lib/terminfo/x/xterm-256color ]; then
    export TERM="xterm-256color"
else
    export TERM="xterm-color"
fi

export EDITOR="vim"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin
