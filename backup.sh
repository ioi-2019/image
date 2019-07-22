#!/bin/bash
# Backup script for contestant machines
# Version 1
#
# Author: Ismayil Hasanov
# Date	: 22 July 2019

# Variables
ETH0=enp2s0f1
SRC=/home/contestant
DST=ioibckp@172.30.20.70:/backup

# Get the IP address of the machine assuming the network adapter is called enp2s0f1
IP4=$(/sbin/ip -o -4 addr list enp2s0f1 | awk '{print $4}' | cut -d/ -f1)
ZIP=/tmp/$IP4.zip

# Zip the home folder of the user
sudo zip -r $ZIP $SRC

# Next, rsync the zipped file to the backup server
rsync -a -e ssh $ZIP $DST
