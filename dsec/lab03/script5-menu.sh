#!/bin/bash

echo "O cliente autorizou?" 
echo "1 - Sim" 
echo "2 - Nao" 
read resp
case $resp in
"1")
	echo "Pode iniciar"
;;
"2")
	echo "Pendente, aguarde!"
;;
esac
