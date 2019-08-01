#!/bin/bash

# Bash script for building the IOI 2019 contest image | WiFi and Bluetooth deactivation. Adding management access.
# Version: 1.3
# http://ioi2019.az/

set -xe

# disable wifi: 

sudo bash -c 'echo blacklist ath10k_pci >> /etc/modprobe.d/blacklist.conf'

### run lspci -nnk | grep -iA2 net to get wifi module name

# disable bluetooth
sudo bash -c 'echo blacklist btusb >> /etc/modprobe.d/blacklist.conf'

# copy public key to ansible user's ssh folder
mkdir /home/ansible/.ssh
cp ./isolate-install-configure/authorized_keys /home/ansible/.ssh/authorized_keys
