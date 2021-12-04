#!/bin/bash

# Install vscode and extensions
if ! [ -x "$(command -v code)" ]; then
  # Install vscode
  sudo snap install --classic code
  # Install vscode extensions
  code --install-extension eamodio.gitlens
  code --install-extension ms-azuretools.vscode-docker
  code --install-extension ms-mssql.mssql
  code --install-extension ms-vscode-remote.remote-containers
fi
