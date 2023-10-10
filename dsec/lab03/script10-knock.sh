#!/bin/bash

ip=37.59.174.235

hping3 -S -p 13 -c 1 $ip
hping3 -S -p 37 -c 1 $ip
hping3 -S -p 30000 -c 1 $ip
hping3 -S -p 3000 -c 1 $ip
hping3 -S -p 1337 -c 1 $ip

nmap -sV $ip

#hping3 -S -p 21 -c 1 $ip 
#hping3 -S -p 22 -c 1 $ip 
#hping3 -S -p 23 -c 1 $ip 
#hping3 -S -p 80 -c 1 $ip 
#hping3 -S -p 443 -c 1 $ip 
#hping3 -S -p 1337 -c 1 $ip

