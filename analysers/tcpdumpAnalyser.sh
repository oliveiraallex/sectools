#!/bin/bash
set -e

echo
echo "TCPDump Analyser 0.1 - 2020  OLIVEIRA Allex"
echo "https://github.com/oliveiraallex/sectools/analysers/"
echo
echo "usage: ./tcpdumpanalyser.sh file.pcap"
echo 

PCAP_FILE=$1

PS3="Select the option: "

items=('Packets number'
'IP information' 
'SYN Flags sent by IP source' 
'SYN Flags sent by IP source (different ports)'
'SYN Flags received by IP destination'
'SYN Flags received by IP destination (different ports)' 
'Open TCP ports by IP'
'Data traffic by SOCKET'
)

select item in "${items[@]}" Quit
do
    case $REPLY in
        1) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n"
	tcpdump -nr $PCAP_FILE | wc -l
	echo ;;
	
	2) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n Enter the IP source:\n"
	read IP
	echo "MAC Address of IP: $IP"
	tcpdump -venr $PCAP_FILE src host $IP | cut -d " " -f 2 | sort | uniq -c | sort -u | grep -E "[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}" 	
	echo ;;	

	3) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n"
	tcpdump -nr $PCAP_FILE 'tcp[tcpflags]=2' | awk '{print $3}' | cut -d. -f1,2,3,4 | sort | uniq -c | sort -nr 
	echo;;

	4) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n Enter the IP source:\n"
	read IP
	tcpdump -nr scan_interno.pcap 'tcp[tcpflags]=2 and src host ' $IP | awk '{print $5}' | cut -d "." -f5 | sort | uniq -c | sort -r | wc -l
	echo ;;

        5) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n" 
	tcpdump -nr $PCAP_FILE 'tcp[tcpflags]=2' | awk '{print $5}' | cut -d. -f1,2,3,4 | sort | uniq -c | sort -nr 
	echo;;

	6) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n Enter the IP source:\n"
	read IP
	tcpdump -nr scan_interno.pcap 'tcp[tcpflags]=2 and dst host ' $IP | awk '{print $5}' | cut -d "." -f5 | sort | uniq -c | sort -r | wc -l
	echo ;;

	7) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n Enter the IP source:\n"
	read IP
	tcpdump -vnr scan_interno.pcap 'tcp[13] & 1 != 0' and src host 192.168.0.23 | grep -v "tos" | sort -uV | cut -d " " -f5 | cut -d "." -f5
	echo ;;

	8) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n Enter the IP source:\n"
	read IP
	echo "Enter the TCP port number:"
	read PORT
	tcpdump -vnAr scan_interno.pcap 'tcp[13] & 8 != 0' and host $IP and tcp port $PORT | grep -v "tos" | grep -v "E\."
	echo ;;


        $((${#items[@]}+1))) echo "We're done!"; break;;
        *) echo "Ooops - unknown choice $REPLY";;
    esac
done
