#!/bin/bash

# Install JDK
if ! [ -x "$(command -v java)" ]; then
  sudo apt -y install default-jdk
fi