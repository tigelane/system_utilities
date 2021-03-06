#!/bin/bash

# Installs github Actions runner on Ubuntu 18.04

# Update system and install git
sudo apt-get update
sudo apt-get -y install git
sudo apt-get -y install packer
sudo apt-get -y install unzip

# Install Docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
apt-cache madison docker-ce
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker ${USER}

echo "Please Log out and log back in.  When you come back run part2."