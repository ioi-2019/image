#!/bin/bash
# Change CSV file, update DHCP reservation file
# and seat web service import file
#
# Author: Ismayil Hasanov
# Date	: 26 July 2019

# Exit immediately if anything returns a non-zero status.
set -e

### Variables
dhcp_dir="/etc/dhcp/"
file="contestant-static.conf"
dhcp_conf=$dhcp_dir$file
main_csv="../../../SeatLocator/DATA_Export.csv"
spare_laptops="laptops.csv"

# Backup the conf file
cp $dhcp_conf ./$file.$(date +"%Y%m%d-%H%M%S")

# Test
# dhcp_conf="mac_out.txt"

### Function declarations ###
show_usage() {
	echo "Usage: $0 seat reserve_laptop_number" 1>&2
	exit 1
}

swap_macs() {
	# $1=old_mac $2=new_mac $3=file
	# sudo sed -i -e "s/$1/$2/g" -e t -e "s/$2/$1/g" $3
	sudo sed -i -e "s/$1/$2/g" $3
}

### Main program ###

if [ $# -ne 2 ]; then
	show_usage
else # 2 arguments, good to go
	
	# check seat
	# capitalize it for faster regexp match
	seat=$1
	seat=${seat^^}
	seat_regex="^[A-H]([1-9]|[1-3][0-9]|4[0-8])$"
	if [ $(echo $seat | egrep $seat_regex) ]; then
		# search for the seat and extract mac (1st field)
		# from $main_csv
		mac_addr=$(cat $main_csv | grep $seat | cut -d"," -f1)
		if [ ! -z $mac_addr ]; then
                	old_mac=$mac_addr
		else
			# seat NOT in CSV
			echo "Seat does not exist in CSV file" 1>&2
			exit 5
		fi
	else
		echo "Invalid seat" 1>&2
		show_usage
	fi
	
	# check laptop number
	laptop_no=$2
	mac_addr=$(cat $spare_laptops | grep $laptop_no | cut -d"," -f2)
	if [ ! -z $mac_addr ]; then
                new_mac=$mac_addr
        else
                # laptop number NOT in spare laptops file
                echo "Laptop number is not in spare laptops file" 1>&2
                exit 6
        fi
fi

# Show the accepted mac addresses
printf "Old mac address: ${old_mac}\n"
printf "New mac address: ${new_mac}\n"

### DHCP reconfigure and seat web service import file change ###
if [ -e $dhcp_conf ]
then
	# replace the old_mac with the new_mac inside DHCP file
	# and seat web service import file
	swap_macs $old_mac $new_mac $dhcp_conf
	swap_macs $old_mac $new_mac $main_csv
	printf "See the new state below:\n"
	grep -A2 -B1 "${new_mac}" $dhcp_conf
else
	echo "DHCP configuration file is missing!"
	exit 2
fi

#### Restart the DHCP service ###
## added administrator user for sudo NOPASSWD
#printf "DHCP server is restarting...\n"
#sudo systemctl restart isc-dhcp-server.service
#printf "DHCP server restarted.\n"
#systemctl status isc-dhcp-server.service
#
