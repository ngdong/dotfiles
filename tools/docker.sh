#!/bin/bash

if ! [ -x "$(command -v docker)" ]; then
  # Install docker
  # First, update your existing list of packages:
  sudo apt update
  # Then add the GPG key for the official Docker repository to your system:
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  # Add the Docker repository to APT sources:
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  # Next, update the package database with the Docker packages from the newly added repo:
  sudo apt update
  # Make sure you are about to install from the Docker repo instead of the default Ubuntu repo:
  apt-cache policy docker-ce
  # Finally, install Docker:
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  # Install a specific version
  sudo apt-get install docker-ce=5:18.09.1~3-0~ubuntu-xenial docker-ce-cli=5:18.09.1~3-0~ubuntu-xenial containerd.io
  # Docker should now be installed, the daemon started, and the process enabled to start on boot. Check that it's running:
  docker --version
  # If you want to avoid typing sudo whenever you run the docker command then set permisison docker.sock file:
  sudo chmod 666 /var/run/docker.sock
  # Create the docker group.
  sudo groupadd docker
  # Add your user to the docker group
  sudo usermod -aG docker $USER
fi
if ! [ -x "$(command -v docker-compose)" ]; then
  # Install docker compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  # Set permission
  sudo chmod +x /usr/local/bin/docker-compose
  # Show version
  docker-compose --version
fi
