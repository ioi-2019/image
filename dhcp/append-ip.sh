#!/bin/bash
# Append random IP addresses to the CSV file
#
# Author: Ismayil Hasanov
# Date	: 25 July 2019

# Exit immediately if anything returns a non-zero status.
set -e

# Check for the passed argument
if [ $# -eq 0 ]; then
	echo "Supply the CSV file, please."
	exit 100;
fi

# Variables
INPUT=$1
OUTPUT=IP_$1
range_begin=150
range_end=190
host=$range_begin
network=20
prefix="172.30."
max_hosts=$(( (range_end-range_begin)*2 ))

# Check if the CSV file contains less than max_hosts machines
mac_no=$(cat $INPUT | wc -l)
if (( mac_no > max_hosts )); then
	echo "Check the CSV file, it contains more addresses."
	exit 99;
fi

# Clear the existing output file, create otherwise
if [ -f $OUTPUT ]; then
    rm $OUTPUT
fi
touch $OUTPUT

# Read the CSV file and append IPs
while read mac
do
	if (( host > range_end )); then
		host=$range_begin
		network=$(( network+1 ))
	fi
	IP=$prefix$network.$host
	echo "$mac,$IP,,,," >> $OUTPUT
	host=$(( host+1 ))
done < $INPUT
