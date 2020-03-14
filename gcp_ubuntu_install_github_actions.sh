# Installs github Actions runner on Ubuntu 18.04

# Update system and install git
sudo apt-get update
sudo apt-get -y install git

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
# Log out and log back in
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker


# Setup a cron job to clean the docker containers up
sudo crontab -e
# Add the following line to run the cleanup file
01 04 * * * /home/ignw/action-runner/cleanup-all.sh
# Modify for userid and folders, etc.

# cleanup file
touch cleanup-all.sh
chmod 755 cleanup-all.sh
vi cleanup-all.sh
sudo docker rmi -f $(docker images -q --filter "dangling=true")
sudo docker rm -vf $(docker ps -aq)
sudo docker rmi -f $(docker images -aq)
sudo docker volume prune -f
# sudo rm -R example_folder/_work


# Run the GitHub Actions installer
rm actions-runner-linux-x64-2*
sudo ./svc.sh install
sudo ./svc.sh start
