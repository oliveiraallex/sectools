#!/bin/bash

echo {1..10}
echo {a..z}
echo {1000..1010}
seq 1 10
for ip in {1..10};do echo 192.168.0.$ip;done

for ips in $(seq 110 120);
do
echo 172.16.1.$ips
done

# while true; do echo "action";done
