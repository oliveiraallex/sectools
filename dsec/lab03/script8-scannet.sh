#!/bin/bash

if [ "$1" == "" ]
then
	echo "DESEC - PORTSCAN Network"
	echo "Mode usage: $0 NETWORK PORT"
	echo "Example: $0 192.168.1"
else
for ip in {1..254};
do 
hping3 -S -p $2 -c 1 $1.$ip 2> /dev/null | grep "flags=SA" | cut -d " " -f 2 | cut -d "=" -f 2;
done
fi
