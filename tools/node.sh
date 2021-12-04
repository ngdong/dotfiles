#!/bin/bash

if ! [ -x "$(command -v node)" ]; then
  # Install Node using the Node version manager
  curl -fsSL https://fnm.vercel.app/install | bash
  # Install node v12
  /home/$USER/.fnm/fnm install lts/erbium
fi
