#!/bin/bash

# Bash script for runnig sequently all automation, installation and configure scripts
# Version: 1.2
# http://ioi2019.az/

# If 'contestant' is given as a parameters, all steps will be run.
# otherwise only worker setup will be done.

./isolate-install-configure/10-system-isolation.sh
./isolate-install-configure/15-wifi_bluetooth_ansible.sh

if [ $1 == 'contestant' ]; then
  ./isolate-install-configure/20-static-image-config.sh
  ./isolate-install-configure/30-dynamic-image-config.sh
  ./isolate-install-configure/40-software-installation.sh
  ./isolate-install-configure/50-desktop-configuration.sh
  ./isolate-install-configure/60-backup-installation.sh
fi

./isolate-install-configure/70-zabbix-installation.sh
