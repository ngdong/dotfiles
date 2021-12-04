#!/bin/bash

# Install dotnet 3.1
if ! [ -x "$(command -v dotnet)" ]; then
  # Add the Microsoft package signing key to your list of trusted keys and add the package repository
  wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  # Install the SDK
  sudo apt-get update;
  sudo apt-get install -y apt-transport-https
  sudo apt-get update
  sudo apt-get install -y dotnet-sdk-3.1
  # Remove package file
  rm -rf packages-microsoft-prod.deb
fi