#!/bin/bash
echo "DESEC SECURITY"
echo "Type the service to start:"
read var1
service $var1 restart
echo "Services active:" 
ps aux | grep $var1
echo "Active ports"
netstat -nlpt
