#!/bin/bash

source $DOTFILES/install/functions.sh

INSTALL_FILE='packages.txt'

install_app() {
    local package=$1
    if ask "Do you want to install $package" < /dev/tty; then
        npm install -g "$package"
    fi
}


# Reading instalation file and installing each app listed on the file
while read -r package; do
  install_app $package
done < "$DOTFILES/npm/$INSTALL_FILE"

echo "Packages installed"
