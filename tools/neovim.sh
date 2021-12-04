#!/bin/bash

# Exit immediately if a neovim exits.
if [ -x "$(command -v nvim)" ]; then
  exit 0
fi
# Installing neovim
sudo apt-get install -y neovim
# Installing Python NeoVim client
if ! [ -x "$(command -v python3)" ]; then
  sudo apt -y install python3
fi
if ! [ -x "$(command -v pip3)" ]; then
  sudo apt -y install python3-pip
fi
pip3 install neovim

# Installing node neovim package
npm install -g neovim

# Installing vim linter
pip3 install vim-vint

# Installing bash language server
npm i -g bash-language-server

# Creating backup directory.
mkdir -p $PWD/backup

# Backup config files
files=("$HOME/.config/nvim")
for filename in "${files[@]}"; do
  if [ ! -L $filename ]; then
    echo "---------------------------------------------------------"
    echo "$(tput setaf 2)Backing up $filename.$(tput sgr 0)"
    echo "---------------------------------------------------------"
    mv $filename $BACKUP_DIR 2>/dev/null
  else
    echo "---------------------------------------------------------"
    echo -e "$(tput setaf 3)$filename does not exist at this location or is a symlink.$(tput sgr 0)"
    echo "---------------------------------------------------------"
  fi
done

# Creating nvim config directory.
if [ -d "$HOME/.config/nvim" ]
then
  echo "$(tput setaf 3)Config directory already exists... Skipping.$(tput sgr 0)"
else
  mkdir -p "$HOME/.config/nvim"
fi
# Linking dotfiles
for config in $PWD/configs/nvim/*; do
  target=$HOME/.config/nvim/$( basename $config )
  if [ -e $target ]; then
    echo "---------------------------------------------------------"
    echo "$(tput setaf 3)Install: ~${target#$HOME} already exists... Skipping.$(tput sgr 0)"
    echo "---------------------------------------------------------"
  else
    echo "---------------------------------------------------------"
    echo "$(tput setaf 2)Install: Creating symlink for ${config}.$(tput sgr 0)"
    echo "---------------------------------------------------------"
    ln -s $config $target
  fi
done

# Creating backup directory
if [ -d "$HOME/.local/share/nvim/backup" ]
then
  echo "$(tput setaf 3)Backup directory already exists... Skipping.$(tput sgr 0)"
else
  mkdir -p "$HOME/.local/share/nvim/backup"
fi
# Installing Neovim plugins
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall
