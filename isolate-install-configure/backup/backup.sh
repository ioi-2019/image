#!/bin/bash
# Backup script for contestant machines
#
# Author: Ismayil Hasanov
# Date	: 02 August 2019

# Variables
ETH0=enp2s0f1
IP=$(/sbin/ip -o -4 addr list $ETH0 | awk '{print $4}' | cut -d/ -f1)
SRC=/home/contestant
SRV=ioibckp@172.30.20.70
FOLDER=/backup/$IP
DST=$SRV:$FOLDER

# Make sure the backup directory is created
ssh $SRV "mkdir -p $FOLDER"
# Next, rsync the source folder to the backup server
rsync -az --max-size=10m --exclude-from=/home/ansible/exclude $SRC $DST
