#!/bin/bash
set -e

echo
echo "TCPDump Analyser 0.1 - 2022  OLIVEIRA Allex"
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
	echo -e "\033[0;32m tcpdump -nr $PCAP_FILE | wc -l \033[0m \n"
	tcpdump -nr $PCAP_FILE | wc -l
	echo ;;
	
	2) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n Enter the IP source:\n"
	read IP
	echo "MAC Address of IP: $IP"
	echo -e "\033[0;32m tcpdump -venr $PCAP_FILE src host $IP | cut -d ' ' -f 2 | sort | uniq -c | sort -u | grep -E '[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}'  \033[0m \n" 	
	tcpdump -venr $PCAP_FILE src host $IP | cut -d " " -f 2 | sort | uniq -c | sort -u | grep -E "[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}" 	
	echo ;;	

	3) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n"
	echo -e "\033[0;32m tcpdump -nr $PCAP_FILE 'tcp[tcpflags]=2' | awk '{print $3}' | cut -d. -f1,2,3,4 | sort | uniq -c | sort -nr  \033[0m \n"
	tcpdump -nr $PCAP_FILE 'tcp[tcpflags]=2' | awk '{print $3}' | cut -d. -f1,2,3,4 | sort | uniq -c | sort -nr 
	echo;;

	4) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n Enter the IP source:\n"
	read IP
	echo -e "\033[0;32m tcpdump -nr $PCAP_FILE 'tcp[tcpflags]=2 and src host ' $IP | awk '{print $5}' | cut -d '.' -f5 | sort | uniq -c | sort -r | wc -l  \033[0m \n"
	tcpdump -nr $PCAP_FILE 'tcp[tcpflags]=2 and src host ' $IP | awk '{print $5}' | cut -d "." -f5 | sort | uniq -c | sort -r | wc -l
	echo ;;

        5) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n"
	echo -e "\033[0;32m tcpdump -nr $PCAP_FILE 'tcp[tcpflags]=2' | awk '{print $5}' | cut -d. -f1,2,3,4 | sort | uniq -c | sort -nr  \033[0m \n"
	tcpdump -nr $PCAP_FILE 'tcp[tcpflags]=2' | awk '{print $5}' | cut -d. -f1,2,3,4 | sort | uniq -c | sort -nr 
	echo;;

	6) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n Enter the IP source:\n"
	read IP
	echo -e "\033[0;32m tcpdump -nr $PCAP_FILE 'tcp[tcpflags]=2 and dst host ' $IP | awk '{print $5}' | cut -d '.' -f5 | sort | uniq -c | sort -r | wc -l  \033[0m \n"
	tcpdump -nr $PCAP_FILE 'tcp[tcpflags]=2 and dst host ' $IP | awk '{print $5}' | cut -d "." -f5 | sort | uniq -c | sort -r | wc -l
	echo ;;

	7) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n Enter the IP source:\n"
	read IP
	echo -e "\033[0;32m tcpdump -vnr $PCAP_FILE 'tcp[13] & 1 != 0' and src host $IP | grep -v 'tos' | sort -uV | cut -d " " -f5 | cut -d "." -f5  \033[0m \n"
	tcpdump -vnr $PCAP_FILE 'tcp[13] & 1 != 0' and src host $IP | grep -v "tos" | sort -uV | cut -d " " -f5 | cut -d "." -f5
	echo ;;

	8) echo -e "Selected: \033[0;32m $REPLY) $item \033[0m \n Enter the IP source:\n"
	read IP
	echo -e "\nEnter the TCP port number:\n"
	read PORT
	echo -e "\033[0;32m tcpdump -vnAr $PCAP_FILE 'tcp[13] & 8 != 0' and host $IP and tcp port $PORT | grep -v 'tos' | grep -v 'E\.'  \033[0m \n"
	tcpdump -vnAr $PCAP_FILE 'tcp[13] & 8 != 0' and host $IP and tcp port $PORT | grep -v "tos" | grep -v "E\."
	echo ;;

        $((${#items[@]}+1))) echo "We're done!"; break;;
        *) echo "Ooops - unknown choice $REPLY";;
    esac
done
