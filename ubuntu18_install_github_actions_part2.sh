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
