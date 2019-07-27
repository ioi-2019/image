#!/bin/bash

# Bash script for runnig sequently all automation, installation and configure scripts
# Version: 1.2
# http://ioi2019.az/

./isolate-install-configure/system-isolation.sh
./isolate-install-configure/static_image_config.sh
./isolate-install-configure/dynamic_image_config.sh
./isolate-install-configure/software-installation.sh
./isolate-install-configure/desktop-configuration.sh
