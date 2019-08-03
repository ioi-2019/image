#!/bin/bash

# Bash script for building the IOI 2019 contest image | Backup Timer Installation
# Version: 1.0
# http://ioi2019.az/

set -xe

# Copy files
cp ./isolate-install-configure/backup/backup.sh /home/ansible/
cp ./isolate-install-configure/backup/exclude /home/ansible/
chmod +x /home/ansible/backup.sh
sudo cp ./isolate-install-configure/backup/backup.service ./isolate-install-configure/backup/backup.timer /etc/systemd/system/

# Add ansible user to contestant group so that the home folder does not give "Permission denied"
sudo usermod -a -G contestant ansible

# Moreover, change group permission to +rx in all the files/directories under home folder
sudo chmod -R g+rx /home/contestant

# Enable and start the timer
sudo systemctl enable backup.timer
sudo systemctl start backup.timer
