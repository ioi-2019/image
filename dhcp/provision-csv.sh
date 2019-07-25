#!/bin/bash
# Create a DHCP reservation conf file
# from the given CSV file
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
OUTPUT=contestant-static.conf

# Check if the passed file exists
if [ ! -f $INPUT ]; then
    echo "$INPUT file not found"
    exit 99;
fi
# Clear the existing conf file, create otherwise
if [ -f $OUTPUT ]; then
    rm $OUTPUT
fi
touch $OUTPUT

# Read the CSV file and create a reservation per host
client=1
printf "#Reservations\n" >> $OUTPUT
while IFS=, read mac ip
do
	echo "host client$client {" >> $OUTPUT
	echo -e "\thardware ethernet $mac;" >> $OUTPUT
	echo -e "\tfixed-address $ip;" >> $OUTPUT
	printf "}\n\n" >> $OUTPUT
	client=$(( client+1 ))
done < $INPUT
printf "### End of Reservations\n" >> $OUTPUT

