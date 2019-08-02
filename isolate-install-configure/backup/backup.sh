#!/bin/bash
# Backup script for contestant machines
#
# Author: Ismayil Hasanov
# Date	: 02 August 2019

# Variables
ETH0=enp2s0f1
IP4=$(/sbin/ip -o -4 addr list $ETH0 | awk '{print $4}' | cut -d/ -f1)
SRC=/home/contestant
DST=ioibckp@172.30.20.70:/backup/$IP4

# Next, rsync the source folder to the backup server
rsync -a -z $ZIP $DST
