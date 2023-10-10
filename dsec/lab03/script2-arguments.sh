#!/bin/bash

if [ "$1" == "" ]
then
	echo "DESEC SECURITY"
	echo "Modo de uso: $0 ip port"
else
	echo "Explorando o host: $1 na porta: $2" 
fi
