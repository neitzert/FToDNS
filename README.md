# FToDNS
## Christopher Neitzert <chris@neitzert.com>

File Transfer over Domain Name Service

A proof of concept that utilizes the Domain Name Service protocol, loosely, as it was intended for data delivery and exfiltration across network boundaries.

Requirements:
Any Unix like OS, access to named's logfiles on server side, ability to use host, base64, and general shell primitive commands on client and server side, and a network between you.

How:  
Using standard linux commands and methods that should work in any implementation of sh on any Unix like operating system.

Why:
This has been a common trope in hacker/infosec circles for the past 35+ years but I have never seen it published. 

ZoneGet.sh
Simple script to query a DNS server and decode the output of an entire DNS zone where each CNAME entry in the zone is a line fragment of a double base64 encoded file created by the script ZoneMaker.sh. 

ZoneMaker.sh
Simple script to take a file and base64 encode it, write it into a DNS zone file for remote serving on a Bind9 DNS server.

Resolver.sh
# Quick and dirty script to copy data via IPv4
# Simply change '2001:db8:1:1:1:1:1:1' to your 
# IPv6 Address For IPv4, removing the '-6' arg 
# on every host command.

#
# This should work on every linux distribution with basic gnutuils install
# Only requirements are to have access to logfile on dns server used for query
# - may wish to consider base32 encoding for non bind9 destination servers.
#

