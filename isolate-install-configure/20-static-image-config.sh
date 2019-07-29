
#sleep mode off

gsettings set org.gnome.desktop.session idle-delay 0

#create local.d for power management

sudo mkdir /etc/dconf/db/local.d
cd /etc/dconf/db/local.d
sudo mkdir locks
sudo touch 10-disable-powersaving  10-universal-access

sudo sh -c 'echo "[org/gnome/settings-daemon/plugins/power]
sleep-inactive-ac-type='nothing'
sleep-inactive-battery-type='nothing'
idle-dim=false
power-button-action='nothing'

[org/gnome/desktop/session]
idle-delay=uint32 0
lock-enabled=false

[org/gnome/desktop/lockdown]
disable-lock-screen=true" >> 10-disable-powersaving'

#add rules
sudo sh -c 'echo "[org/gnome/desktop/a11y]
always-show-universal-access-status=true" >> 10-universal-access'

#manage above files with lock directory
cd locks
sudo touch diable-powersaving
sudo sh -c 'echo "/org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type
/org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-type
/org/gnome/settings-daemon/plugins/power/idle-dim
/org/gnome/settings-daemon/plugins/power/power-button-action
/org/gnome/desktop/session/idle-delay
/org/gnome/desktop/session/lock-enabled
/org/gnome/desktop/lockdown/disable-lock-screen" >> diable-powersaving'

#disable wifi: 

sudo sh -c 'echo blacklist ath10k_pci >> /etc/modprobe.d/blacklist.conf'

### run lspci -nnk | grep -iA2 net to get wifi module name


#disable bluetooth

sudo sh -c 'echo blacklist btusb >> /etc/modprobe.d/blacklist.conf'


