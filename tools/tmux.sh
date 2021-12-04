# #!/bin/bash

if ! [ -x "$(command -v tmux)" ]; then
  # Install tmux
  sudo apt-get -y install tmux
fi
if ! [ -x "$(command -v xsel)" ]; then
  # Install xsel
  sudo apt-get -y install xsel
fi
if ! [ -x "$(command -v xclip)" ]; then
  # Install xclip
  sudo apt-get -y install xclip
fi
# Remove carriage return and newline from a variable in shell script
sed -i 's/\r//g' $PWD/configs/tmux.conf
# Create syslink
ln -sf "$PWD/configs/tmux.conf" "$HOME/.tmux.conf"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    # Install plugin
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi
# Reload tmux environment
tmux source ~/.tmux.conf
# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# killing the server is not required, I guess
tmux kill-server
