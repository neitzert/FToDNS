# FToDNS
File Transfer over Domain Name Service

What:
A proof of concept that utilizes the Domain Name Service protocol, loosely, as it was intended for data delivery and exfiltration across network boundaries.

Requirements:
Any Unix like OS, access to named's logfiles on server side, ability to use host, base64, and general shell primitive commands and a network between you.

How:  
Using standard linux commands and methods that should work in any implementation of sh on any Unix like operating system.


Why:
This has been a common trope in hacker/infosec circles for the past 35+ years but I have never seen it published. 




This should work on every linux distribution with basic gnutuils install
Only requirements are to have access to logfile on dns server used for query
may wish to consider base32 encoding for non bind9 destination servers.