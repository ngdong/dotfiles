#!/bin/bash

ZSH_CUSTOM=~/.oh-my-zsh/custom

if ! [ -x "$(command -v zsh)" ]; then
  # Install zsh
  sudo apt-get -y install zsh
fi
if ! [ -x "$(command -v powerline)" ]; then
  # Install powerline
  sudo apt-get -y install powerline
fi
if ! [ -x "$(command -v fonts-powerline)" ]; then
  # Install fonts-powerline
  sudo apt-get -y install fonts-powerline
fi
if ! [ -x "$(command -v ripgrep)" ]; then
  # Install ripgrep
  sudo apt-get -y install ripgrep
fi
if ! [ -x "$(command -v fzf)" ]; then
  # Install fzf
  sudo apt-get -y install fzf
fi
if ! [ -x "$(command -v ruby)" ]; then
  # Install ruby ruby-dev ruby-colorize
  sudo apt-get -y install ruby ruby-dev ruby-colorize
  sudo gem install colorls
fi
if ! [ -x "$(command -v zoxide)" ]; then
  # Install zoxide
  curl -sS https://webinstall.dev/zoxide | bash
fi

# Update the nerd fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DejaVuSansMono.zip
unzip DejaVuSansMono.zip
rm -rf DejaVuSansMono.zip
cd ~/dotfiles

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  # Install ohmyzsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  # Install plugin Syntax Highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
  # Install plugin Autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
  # Install theme Spaceship
  git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM}/themes/spaceship-prompt
  # Create syslink
  ln -s ${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM}/themes/spaceship.zsh-theme
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Oh-my-zsh already installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
fi

# Create syslink
ln -sf "$PWD/configs/zshrc" "$HOME/.zshrc"
