## Description of files

# Backup
**backup.sh** - Zips contestant home folder and sends to a central location

**clear-zip.sh** - Removes the zipped file before the next run of the service

**backup.service** - Systemd unit file maintaining the backup process

**backup.timer** - 5min systemd timer file that needs to be enabled on contestant machines

# Monitoring
**contestant_worker_zabbix_agent.txt** - Steps needed to install zabbix monitoring agent on laptops

# Dhcp
Provisioning process is happening as follows:
1. Parse the DHCP lease file for MAC addresses
* **parse-dhcp.sh** - Output is a CSV file with MAC per line
2. Assign IPs to these MAC addresses
* **append-ip.sh** - Variables are configured inside the script. Input is the output of **parse-dhcp.sh**. Output is a CSV file with MAC,IP per line
3. MAC,IP CSV file will be provisioned to DHCP
* **provision-csv.sh** - Variables are configured inside the script. Input is the output of **append-ip.sh**. Output is a DHCP conf file with MAC,IP reservations that should be copied to /etc/dhcp/. Then run: **sudo systemctl restart isc-dhcp-server**

4. (OUTSTANDING) Get seat id by web service and add it as a new column: MAC, IP, seat.
