#!/bin/sh
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Download command for this script
exit
wget -O debian_install_docker.sh https://raw.githubusercontent.com/tigelane/system_utilities/master/debian_install_docker.sh && chmod +x debian_install_docker.sh
