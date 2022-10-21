#!/bin/bash

export IFS=","

cat /home/azdine/Projet-FTP/JOB-09/Shell_Userlist.csv | while read Id Prenom Nom Mdp Role 
do 
sudo useradd -m $Prenom-$Nom
echo "$Prenom-$Nom:$Mdp" | sudo chpasswd
sudo usermod -u $Id "$Prenom-$Nom"
if [ $Role = "admin" ]
then
sudo usermod -aG sudo "$Prenom-$Nom"
fi
done

sudo apt update && sudo apt upgrade && sudo apt install proftpd-*

conf=$(sudo /etc/proftpd/proftpd.conf)
tls=$(sudo /etc/proftpd/tls.conf)

sudo mkdir /etc/proftpd/shell

sudo openssl req -newkey rsa:4096 -x509 -keyout /etc/proftpd/ssl/proftpd.key.pem -days 30 -nodes -out /etc/proftpd/ssl/proftpd.cert.pem 

sudo chmod 666 /etc/proftpd/ssl/proftpd.key.pem
sudo chmod 666 /etc/proftpd/ssl/proftpd.cert.pem

sudo /etc/init.d/proftpd restart

