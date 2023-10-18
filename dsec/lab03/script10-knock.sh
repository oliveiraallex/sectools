#!/bin/bash

ip=37.59.174.235

hping3 -S -p 13 -c 1 $ip
hping3 -S -p 37 -c 1 $ip
hping3 -S -p 30000 -c 1 $ip
hping3 -S -p 3000 -c 1 $ip
hping3 -S -p 1337 -c 1 $ip
nmap -Pn -sV $ip -p 1337
{ echo "GET / HTTP/1.0"; echo ""; sleep 1; } | telnet $ip 1337

