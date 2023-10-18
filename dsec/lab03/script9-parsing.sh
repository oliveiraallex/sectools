#!/bin/bash

if [ "$1" == "" ]
then
	echo "Script usage: $0 URL"
	echo "Example: $0 businesscorp.com.br"
else
wget --no-check-certificate --secure-protocol=auto --user-agent="Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/118.0" --referer="https://google.com" -O index $1 
#2> /dev/null

grep href index | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" | grep -v "><" | sort -u > lista

for url in $(cat lista);do host $url | grep -v "not" | sed 's/ has address / /' | sed 's/ has IPv6 address / /';done


fi
