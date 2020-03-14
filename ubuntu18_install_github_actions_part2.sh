#!/bin/bash
sudo systemctl start docker
sudo systemctl enable docker
# sudo systemctl status docker
# Setup a cron job to clean the docker containers up
line="01 04 * * * /home/${USER}/cleanup-all.sh"
(crontab -u ${USER} -l; echo "$line" ) | crontab -u ${USER} -
# cleanup file
touch cleanup-all.sh
chmod 755 cleanup-all.sh
echo 'sudo docker rmi -f $(docker images -q --filter "dangling=true")
sudo docker rm -vf $(docker ps -aq)
sudo docker rmi -f $(docker images -aq)
sudo docker volume prune -f
' > cleanup-all.sh

# Run the GitHub Actions installer 
# Then do the following
echo "## Please Run the GitHub Actions installer, then run the following from the githab actions folder:"
echo "rm actions-runner-linux-x64-2*"
echo "sudo ./svc.sh install"
echo "sudo ./svc.sh start"