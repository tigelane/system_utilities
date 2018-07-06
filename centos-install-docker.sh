sudo yum install yum-utils device-mapper-persistent-data lvm2 -y
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
sudo docker run -dp 80:80 httpd


yum install telnet-server telnet -y
systemctl start telnet.socket

ping 10.2.1.204
