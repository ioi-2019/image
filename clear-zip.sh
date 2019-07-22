#!/bin/bash
# Backup clear script for contestant machines
# Version 1
#
# Author: Ismayil Hasanov
# Date	: 22 July 2019

# Variables
ETH0=enp2s0f1

# Get the IP address of the machine assuming the network adapter is called enp2s0f1
IP4=$(/sbin/ip -o -4 addr list enp2s0f1 | awk '{print $4}' | cut -d/ -f1)
ZIP=/tmp/$IP4.zip

# Remove the local zip file, fi exists
if [ -f $ZIP ]; then
    sudo rm $ZIP
else
    echo "Skipping ..."
fi
