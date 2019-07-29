#!/bin/bash

# Bash script for runnig sequently all automation, installation and configure scripts
# Version: 1.2
# http://ioi2019.az/

./isolate-install-configure/10-system-isolation.sh
./isolate-install-configure/20-static-image-config.sh
./isolate-install-configure/30-dynamic-image-config.sh
./isolate-install-configure/40-software-installation.sh
./isolate-install-configure/50-desktop-configuration.sh
./isolate-install-configure/60-backup-installation.sh
./isolate-install-configure/70-zabbix-installation.sh
