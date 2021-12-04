#!/bin/bash

# Load config file
source "$PWD/environment"

# Check if the function is set up, if not then set up
if ! [ -x "$(command -v git)" ]; then
  # Install git
  sudo apt-get -y install git
fi

# Config global username and email
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"

# Git config post Buffer
git config --global http.postBuffer 500M
git config --global http.maxRequestBuffer 100M
git config --global core.compression 0

# Set git to use the credential memory cache
git config --global credential.helper cache
git config --global credential.helper store

# Set the cache to timeout after 8 hour (setting is in seconds)
git config --global credential.helper 'cache --timeout=28800'

# Adding global .ignore file
touch ~/.gitignore_global

# Make all the patterns from ~/.gitignore_global ignored in all situations.
git config --global core.excludesfile ~/.gitignore_global