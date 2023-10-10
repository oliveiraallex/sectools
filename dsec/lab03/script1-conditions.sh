#!/bin/bash

echo "What is the signal color?"
read cor
if [ "$cor" == "verde" ]
then
	echo "Go ahead"
elif [ "$cor" == "amarelo" ]
then
	echo "WAIT!"
else
	echo "STOP!" 
fi
