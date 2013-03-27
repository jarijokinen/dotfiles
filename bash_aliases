if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls --color=auto"
    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"
fi

alias back="cd $OLDPW"
alias f="find . | grep"
alias l="ls -lah"
alias mkdir="mkdir -p"
alias p="pwsafe -p"
alias pk="pwsafe -p jari.pubkey"
alias s="ssh-add"
alias u="pwsafe -u"
alias up="pwsafe -up"
alias v="vim"

alias big="find . -size +20000k -exec du -h {} \;"
alias myip="/sbin/ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | cut -d' ' -f1"
alias update="sudo apt-get update; sudo apt-get dist-upgrade; rvm get stable; rvm install 2.0.0; gem update --system; gem update"

alias add="git add ."
alias commit="git commit"
alias push="git push origin master"
alias deploy="cap deploy"
alias deploy!="cap deploy:migrations"
