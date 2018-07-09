#!/bin/sh
sudo apt update && sudo apt dist-upgrade && sudo apt autoremove
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c "echo 'deb https://pkg.jenkins.io/debian-stable binary/' > /etc/apt/sources.list.d/Jenkins.list"
sudo apt update
sudo apt install jenkins


# Download command for this script
exit
sudo systemctl stop jenkins.service
sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service

http://localhost:8080
wget -O debian_install_docker.sh https://raw.githubusercontent.com/tigelane/system_utilities/master/debian_install_docker.sh && chmod +x debian_install_docker.sh
