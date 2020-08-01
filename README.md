# FToDNS: File Transfer over Domain Name Service
Christopher Neitzert <chris@neitzert.com>

### What:
A proof of concept that utilizes the Domain Name Service protocol, loosely, as it was intended for data delivery and exfiltration across network boundaries.

### Why:
The use of DNS for data exfiltration or VPN has been a hacker trope for the four decades that DNS has existed.
Recently with the creation of [DNS over HTTPS](https://en.wikipedia.org/wiki/DNS_over_HTTPS) in order to protect those that may be censored we inadvertadnly create an uncontrolable channel for data in/exfiltration.

There have been several impliementations of this concept and this Proof of Concept is not unique. 
Although this implementation is not based on the previous PoCs, several interesting methods will be linked in the [Erratum.txt](https://github.com/neitzert/FToDNS/Erratum.txt)

### Proof of Concept Criteria and Requirements
1. PoC Criteria
	1. Proof of concept must be limited to tools built into the OS
	1. Some sort of TCP-IP network between client & server that permits DNS between Client and Server. 
	1. Proof of concept must be able to, via the DNS protocol, 
		1. Copy a file from a remote server to a local client across a network
		1. Copy a file on a local client to a remote server across a network

1. Client Requirements:
	1. Standard Linux Distribution with standard GNU Core utils
	1. Host(1) ISC's standard host utility.  
	1. Base64, grep, cut, sed, awk, general sh scripting

1. Server Requirements:
	1. Standard Linux Distribution with standard GNU Core utils
	1. ISC's Bind9 DNS server 
		1. Ability to write zone files
		1. Ability to read log files
		1. Ability to change named.conf to allow zone transfers.
		1. named.conf configuration changes TBD
	1. Base64, grep, cut, sed, awk, general sh scripting


1. Types of Test 
	1. Due to the complexity of the PoC, this will be broken down into multiple types of PoC
		1. - [x]Direct Client to Server
			1. - [x]Read file 
			1. - [x]Write file
		1. - [ ]Client to Recursive to Authoritative
			1. - [ ]Read file
			1. - [ ]Write file
		1. - [ ]Client via DoH to HTTPS/DNS server 
			1. - [ ]Read file
			1. - [ ]Write file




### Requirements:
Any Unix like OS, access to named's logfiles on server side, ability to use host, base64, and general shell primitive commands on client and server side, and a network between the client and server.





### Files:

####Resolver.sh

A simple script to encode a file into a very large number of DNS host look up queries for later collection and reassembly on the upstream DNS server 


####ZoneGet.sh

Simple script to query a DNS server and decode the output of an entire DNS zone where each CNAME entry in the zone is a line fragment of a double base64 encoded file created by the script ZoneMaker.sh. 


####ZoneMaker.sh

Simple script to take a file and base64 encode it, write it into a DNS zone file for remote serving on a Bind9 DNS server.



 
### Disclaimers 
All standard disclaimers apply, no warranty, claims, or promises declared, made or implied.

For educational, research, and entertainment purposes only. 

Usability expires while you wait.

