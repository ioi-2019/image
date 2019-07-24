#!/bin/bash
# Append random IP addresses to the CSV file
#
# Author: Ismayil Hasanov
# Date	: 24 July 2019

# Check for the passed argument
if [ $# -eq 0 ]; then
    echo "Supply the CSV file, please."
    exit 100;
fi

# Variables
INPUT=$1
OUTPUT=IP_$1

# Read the CSV file
while read mac
do
	echo "$mac,IP" >> $OUTPUT
done < $INPUT
