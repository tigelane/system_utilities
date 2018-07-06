#!/bin/sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get -f install -y
# folowing for debian
apt install docker-ce=17.03.2~ce-0~ubuntu-xenial
# Following for pure ubuntu
#sudo apt-get install -y docker-ce
#sudo systemctl status docker
sudo usermod -aG docker ${USER}

# Download and run
exit
wget -O debian_install_docker.sh https://raw.githubusercontent.com/tigelane/system_utilities/master/install_docker_ubuntu.sh && chmod +x debian_install_docker.sh
chmod +x *_install_docker.
