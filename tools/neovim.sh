#!/bin/bash

# Exit immediately if a neovim exits.
if [ -x "$(command -v nvim)" ]; then
  exit 0
fi

# Installing neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y neovim

# Installing Python NeoVim client
if ! [ -x "$(command -v python3)" ]; then
  sudo apt -y install python3
fi

if ! [ -x "$(command -v pip3)" ]; then
  sudo apt -y install python3-pip
fi
# Installing python neovim package
pip3 install neovim

# Installing node neovim package
npm install -g neovim

# Installing vim linter
pip3 install vim-vint

# Installing bash language server
npm i -g bash-language-server

# Installing fonts
git clone https://github.com/terroo/fonts.git
cd fonts/fonts && cp *.ttf *.otf $HOME/.local/share/fonts/
fc-cache -fv

# Installing sqlite
sudo apt-get install sqlite3 libsqlite3-dev

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

# Remove old config
if [ -d "$HOME/.config/nvim" ]
then
  rm -rf ~/.config/nvim
fi
if [ -d "$HOME/.local/share/nvim" ]
then
  rm -rf ~/.local/share/nvim
fi

# Linking dotfiles
ln -s $PWD/configs/nvim ~/.config/
