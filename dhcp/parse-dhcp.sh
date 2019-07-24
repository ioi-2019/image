#!/bin/bash
# Create a incomplete CSV file
# from the given DHCP lease database
#
# Author: Ismayil Hasanov
# Date	: 24 July 2019

# Variables
OUTPUT=ioi2019.csv

cat /var/lib/dhcp/dhcpd.leases | grep "hardware ethernet" | awk '{print $3}' | cut -d";" -f1 | uniq >> $OUTPUT
