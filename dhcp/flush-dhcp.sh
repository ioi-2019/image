#!/bin/bash
# Flush DHCP lease database
# Note: the script requires an admin type sudo password
#
# Author: Ismayil Hasanov
# Date	: 26 July 2019

# Exit immediately if anything returns a non-zero status.
set -e

# Function declaration
info() {
	db=$(cat dhcpd.leases | grep "lease 172" | wc -l)
	temp=$(cat dhcpd.leases~ 2>/dev/null | grep "lease 172" | wc -l)
	echo "DHCP has committed $db and unwritten $temp leases."
}

# Go to DHCP folder
cd /var/lib/dhcp/

# Print lease related info before the flush
echo "===Before==="
info

# Stop, flush and start the service
sudo systemctl stop isc-dhcp-server
sudo rm dhcpd.leases~
sudo bash -c "echo '' > dhcpd.leases"
sudo systemctl start isc-dhcp-server

# Print lease related info after the flush
echo "===After==="
info
