#!/bin/bash

# Genera una nueva clave SSH
ssh-keygen -t ed25519

# Inicia el agente SSH
eval "$(ssh-agent -s)"

# Agrega la clave privada al agente
ssh-add --apple-use-keychain --apple-load-keychain ~/.ssh/id_ed25519

# Agrega la configuración al archivo SSH config
cat $DOTFILES/ssh/config >> ~/.ssh/config

# Copying SSH Key
pbcopy < ~/.ssh/id_ed25519.pub

open https://github.com/settings/ssh/new
