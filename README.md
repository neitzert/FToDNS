# FToDNS: File Transfer over Domain Name Service
Christopher Neitzert <chris@neitzert.com>
##

A proof of concept that utilizes the Domain Name Service protocol, loosely, as it was intended for data delivery and exfiltration across network boundaries.

This PoC should work on every Unix like operating system with GNU Core Utils and Bind9 upstream DNS servers. 

Of course YMMV. 

# Requirements:
Any Unix like OS, access to named's logfiles on server side, ability to use host, base64, and general shell primitive commands on client and server side, and a network between the client and server.

# How:  
Using standard linux commands and methods that should work in any implementation of sh on any Unix like operating system.

# Why:
This has been a common trope in hacker/infosec circles for the past 35+ years yet I have never seen it published as a known method, or even a proof of concept. 
##


# Files:

ZoneGet.sh
Simple script to query a DNS server and decode the output of an entire DNS zone where each CNAME entry in the zone is a line fragment of a double base64 encoded file created by the script ZoneMaker.sh. 

ZoneMaker.sh
Simple script to take a file and base64 encode it, write it into a DNS zone file for remote serving on a Bind9 DNS server.

Resolver.sh
A simple script to encode a file into a very large number of DNS host look up queries for later collection and reassembly on the upstream DNS server 
 
# Disclaimers 
All standard disclaimers apply, no warranty, claims, or promises declared, made or implied.

For educational, research, and entertainment purposes only. 

Usability expires while you wait.

