## Description of files

# Backup
**backup.sh** - Zips contestant home folder and sends to a central location

**clear-zip.sh** - Removes the zipped file before the next run of the service

**backup.service** - Systemd unit file maintaining the backup process

**backup.timer** - 5min systemd timer file that needs to be enabled on contestant machines

# Monitoring
**contestant_worker_zabbix_agent.txt** - Steps needed to install zabbix monitoring agent on laptops
