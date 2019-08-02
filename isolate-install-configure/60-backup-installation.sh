#!/bin/bash

# Bash script for building the IOI 2019 contest image | Backup Timer Installation
# Version: 1.0
# http://ioi2019.az/

set -xe

# Copy files
cp ./isolate-install-configure/backup/*.sh /home/ansible/
cp ./isolate-install-configure/backup/exclude /home/ansible/
chmod +x /home/ansible/*.sh
sudo cp ./isolate-install-configure/backup/backup.service ./isolate-install-configure/backup/backup.timer /etc/systemd/system/

# Enable and start the timer
sudo systemctl enable backup.timer
sudo systemctl start backup.timer
