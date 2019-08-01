#!/bin/bash

# Bash script for building the IOI 2019 contest image | Static configurations
# Version: 1.3
# http://ioi2019.az/

set -xe

# sleep mode off

gsettings set org.gnome.desktop.session idle-delay 0

# create local.d for power management

sudo mkdir /etc/dconf/db/local.d
sudo touch /etc/dconf/db/local.d/10-disable-powersaving  /etc/dconf/db/local.d/10-universal-access
sudo cp ./isolate-install-configure/dconf.file /etc/dconf/db/local.d/10-disable-powersaving

# add rules
sudo bash -c 'echo "[org/gnome/desktop/a11y]
always-show-universal-access-status=true" >> /etc/dconf/db/local.d/10-universal-access'

# manage above files with lock directory
sudo mkdir /etc/dconf/db/local.d/locks
sudo touch /etc/dconf/db/local.d/locks/disable-powersaving
sudo bash -c 'echo "/org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type
/org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-type
/org/gnome/settings-daemon/plugins/power/idle-dim
/org/gnome/settings-daemon/plugins/power/power-button-action
/org/gnome/desktop/session/idle-delay
/org/gnome/desktop/session/lock-enabled
/org/gnome/desktop/lockdown/disable-lock-screen" >> /etc/dconf/db/local.d/locks/disable-powersaving'

# see the changes
sudo touch /etc/dconf/profile/user
sudo bash -c 'cat << EOF > /etc/dconf/profile/user
user-db:user
system-db:local
EOF'

sudo dconf update
