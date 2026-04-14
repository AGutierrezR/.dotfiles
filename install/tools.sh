#!/bin/bash

# Prinf error function that exit out of the script
print_error() {
    echo "Error: Options should be 'apps' or 'cli'"
    exit 1
}

# Checking amount of arguments 
if [ $# -ne 1 ]; then
    print_error
fi

# Checking arguments 
case $1 in
    'apps') INSTALL_FILE='apps.txt'; IS_CASK=true ;;
    'cli' ) INSTALL_FILE='cli-apps.txt'; IS_CASK=false ;;
    *     ) print_error ;;
esac

# Installing apps function
install_app() {
    local app=$1

    if ask "Do you want to install $app?" < /dev/tty; then
        case "$app" in
            atuin)
                curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
                ;;
            *)
                if [ "$IS_CASK" = true ]; then
                    brew install --cask "$app"
                else
                    brew install "$app"
                fi
                ;;
        esac
    fi
}
 
source $DOTFILES/install/functions.sh

# Reading instalation file and installing each app listed on the file
while read -r app; do
    install_app "$app"
done < "$DOTFILES/tools/$INSTALL_FILE"

echo "Apps installed"
