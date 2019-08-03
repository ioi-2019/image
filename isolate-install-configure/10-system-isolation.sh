#!/bin/bash

# Bash script for building the IOI 2019 contest image | CMS Isolate Requirements
# Version: 1.3
# http://ioi2019.az/

set -xe

#swap file off
sudo sed -i '/^\/swapfile/s/^/#/' /etc/fstab

#disable CPU scaling
sudo systemctl disable ondemand

#disable aslr:
sudo touch /etc/sysctl.d/01-disable-aslr.conf
sudo bash -c 'echo kernel.randomize_va_space = 0 >> /etc/sysctl.d/01-disable-aslr.conf'

#disable hugepage-related: 
sudo apt -y install sysfsutils
sudo bash -c 'echo kernel/mm/transparent_hugepage/enabled = never >> /etc/sysfs.conf'
sudo bash -c 'echo kernel/mm/transparent_hugepage/defrag = never >> /etc/sysfs.conf'
sudo bash -c 'echo kernel/mm/transparent_hugepage/khugepaged/defrag = 0 >> /etc/sysfs.conf'
