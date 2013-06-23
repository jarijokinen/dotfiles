#!/bin/sh
#
# This script allows execution of X application as another user.
#
# Sudo must be installed and /etc/sudoers must contain specification
# like this:
#
#   you host=(another_user) NOPASSWD: /path/to/application
#
# For example:
#
#   jari ALL=(web) NOPASSWD: /usr/bin/iceweasel
#
# To create a new user:
#
#   adduser web --disabled-login

application="/usr/bin/iceweasel"
another_user="web"

xhost +SI:localuser:$another_user
sudo -u $another_user -H $application $@
