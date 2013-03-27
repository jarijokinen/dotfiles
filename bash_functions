function engine {
    rails plugin new $1 --full --skip-test-unit --skip-bundle \
        --dummy-path=spec/dummy

    mv $1 /tmp/

    bundle gem $1
    cp -pr /tmp/$1/{app,config,spec} $1/
    cp -pr /tmp/$1/lib/$1/engine.rb $1/lib/$1/
    rm -rf /tmp/$1
}
function templates {
    find ~/.rails/application_templates -maxdepth 1 -type f -printf "%f\n" \
        | cut -d"." -f1 | sort
}
function apply {
    filename=`find ~/.rails/application_templates -maxdepth 1 -type f \
        -name "???-$1.rb" -printf "%f\n"`
    if [ -z "$filename" ]; then
        echo "Template not found!"
        return
    fi
    rake rails:template LOCATION=~/.rails/application_templates/$filename
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
    chmod 644 $HOME/.Xauthority
    chmod 711 $HOME
    echo "OK."

    echo -n "Create symlinks... "
    rm -f $HOME/.xsession-errors
    ln -s /dev/null $HOME/.xsession-errors
    echo "OK."
}
