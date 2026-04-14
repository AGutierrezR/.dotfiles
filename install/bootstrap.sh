#!/bin/bash

cd "$(dirname "$0")/.."
DOTFILES=$(pwd P)

cd "$HOME"

# Checking Xcode and tools
if ! command -v xcode-select -p &> /dev/null; then
  echo "Xcode must be installed (running xcode-select --install)"
  xcode-select --install
else
  echo "Xcode is already installed"
fi

# Checking Homebrew
if ! command -v /opt/homebrew/bin/brew &> /dev/null; then
  echo "Homebrew must be installed (running installation)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "Homebrew is already installed. Getting updates"
  brew update
  brew doctor
fi

# Install brew packages...
echo ">>> Installing brew packages..."
brew bundle install --file $DOTFILES/Brewfile

# Zsh environment files configuration
if [ ! -f $HOME/.zshenv ]; then
  echo "Creating .zshenv file"
  touch $HOME/.zshenv
  echo "export DOTFILES=$DOTFILES" > $HOME/.zshenv
else
  echo "Adding DOTFILES to .zshenv file"
  echo "export DOTFILES=$DOTFILES" > $HOME/.zshenv
fi

# Install all dot files using links.pros files 
bash $DOTFILES/install/linkfiles.sh

echo "All installed!"
