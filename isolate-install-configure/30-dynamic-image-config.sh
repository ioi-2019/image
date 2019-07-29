# copy public key to ansible user's ssh folder
sudo mkdir /home/ansible/.ssh
sudo cp ./isolate-install-configure/authorized_keys /home/ansible/.ssh/authorized_keys

# enable auto login
sudo sed -i '/^\#  AutomaticLoginEnable =/s/#//' /etc/gdm3/custom.conf
sudo sed -i '/^\#  AutomaticLogin =/s/#  AutomaticLogin = user1/  AutomaticLogin = contestant/' /etc/gdm3/custom.conf

# install printer
sudo lpadmin -p ioi_printer -E -v ipp://172.30.20.200:631/printers/ioi_printer -m everywhere
	
# remove USB Storage Modules
sudo touch /root/drivers/usb-storage.ko
mv /lib/modules/$(uname -r)/kernel/drivers/usb/storage/usb-storage.ko /root/drivers/

sudo sh -c 'echo "rmmod usb
rmmod usb_storage
exit 0" >> /etc/rc.local'

sudo sh -c 'echo blacklist uas >> /etc/modprobe.d/blacklist.conf'

### enable of usb storage script is on github

# disable access control for X11 (needed for i3lock and opening remote browser)
sudo sh -c 'printf ("xhost +\n") >> /etc/profile'

# lock using i3lock  
sudo apt install i3lock
touch /etc/systemd/system/i3lock.service
sudo sh -c 'echo "[Unit]
Description=Lock screen

[Service]
User=ansible
Type=simple
Restart=always
RestartSec=60
Environment=DISPLAY=':0.0'
ExecStart=/usr/bin/i3lock -i /home/ansible/lockscreen.png -u -n -t -c 000000
" >> /etc/systemd/system/i3lock.service'

# copy locksreen.png
sudo cp ./isolate-install-configure/lockscreen.png /home/ansible/lockscreen.png