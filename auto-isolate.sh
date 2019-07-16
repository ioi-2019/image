#swap file off
sudo sed -i '/^\/swapfile/s/^/#/' /etc/fstab

#disable CPU scaling
sudo systemctl disable ondemand

#disable aslr:
sudo touch /etc/sysctl.d/01-disable-aslr.conf
sudo sh -c 'echo kernel.randomize_va_space = 0 >> /etc/sysctl.d/01-disable-aslr.conf'

#disable hugepage-related: 
sudo apt install sysfsutils
sudo sh -c 'echo kernel/mm/transparent_hugepage/enabled = never >> /etc/sysfs.conf'
sudo sh -c 'echo kernel/mm/transparent_hugepage/defrag = never >> /etc/sysfs.conf'
sudo sh -c 'echo kernel/mm/transparent_hugepage/khugepaged/defrag = 0 >> /etc/sysfs.conf'
