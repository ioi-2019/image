## Description of files

# Backup
**backup_service_setup.txt** shows the steps necessary to implement contestant backups. Here are the necessary files for this process:

**backup.sh** - Zips contestant home folder and sends to a central location

**clear-zip.sh** - Removes the zipped file before the next run of the service

**backup.service** - Systemd unit file maintaining the backup process

**backup.timer** - 5min systemd timer file that needs to be enabled on contestant machines

# Monitoring
**contestant_worker_zabbix_agent.txt** - Steps needed to install zabbix monitoring agent on laptops

# Dhcp
Provisioning process is happening as follows:

0. Flush the DHCP lease database (Danger: should only be done once thrroughout the event)
* **flush-dhcp.sh** - Flushes the databae and gives out information
1. Parse the DHCP lease file for MAC addresses
* **parse-dhcp.sh** - Output is a CSV file with MAC per line called *ioi2019.csv*
2. Assign IPs to these MAC addresses
* **append-ip.sh** - Variables are configured inside the script. Input is the output of **parse-dhcp.sh**. Output is a CSV file with MAC,IP per line called *IP_ioi2019.csv*
3. MAC,IP CSV file will be provisioned to DHCP
* **provision-csv.sh** - Variables are configured inside the script. Input is the output of **append-ip.sh**. Output is a DHCP conf file with MAC,IP reservations (*contestant-static.conf*))that should be copied to /etc/dhcp/. Then run: `sudo systemctl restart isc-dhcp-server`
4. Get seat id by web service and add it as a new column: MAC, IP, seat
* `sudo cp IP_ioi2019.csv ../../../SeatLocator/data.csv` needs to be run to copy MAC,IP pair to seat web service. Everytime an update occurs to a location, DATA_Export.csv is the one which needs to be exported out of the web service. Relocation scripts will need this file.

# Isolation-Installation-Configuration
To create an **IOI 2019 contestant image**, follow the instructions below:
* download and install **Ubuntu 18.04 (Bionic Beaver)** into your computer machine
* create an user under the name of **contestant**
* run either **sudo ./isolate-install-configure.sh** or **sudo bash isolate-install-configure.sh** command

# Relocation

TODO
