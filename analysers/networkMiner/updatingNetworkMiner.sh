#!/bin/bash
#Updating NetworkMiner

NOW=$(date +%Y-%m-%d-%R)
mv ./NetworkMiner* ./$NOW.bkp.networkMiner

wget https://www.netresec.com/?download=NetworkMiner -O ./nm.zip
sudo unzip nm.zip -d ./
rm nm.zip

cd ./NetworkMiner*
sudo chmod +x NetworkMiner.exe
sudo chmod -R go+w AssembledFiles/
sudo chmod -R go+w Captures/ 
