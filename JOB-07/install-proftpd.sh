#!/bin/bash


#Ajout de deux utilisateurs Merry et Pippin
sudo useradd -m Merry
echo "Merry:kalimac" | sudo chpasswd
sudo useradd -m Pippin
echo "Pippin:secondbreakfast" | sudo chpasswd

#installer lae paquet GIT
sudo apt install git

#install proftpd
sudo apt install proftpd-*

#On met à jour la liste des paquets
sudo apt update
sudo apt upgrade

#Récupération des fichier de config  après le clonnage sur GIT
git clone https://github.com/azdine-zahi/Projet-FTP.git

#Cloner le dossier FTP pour récupérer les fichiers .conf
cd /etc

#Récupérer les dossiers de configuration et les remplacer dans ceux installés
mv /etc/FTP/proftpd.conf /etc/proftpd/proftpd.conf
mv /etc/FTP/tls.conf /etc/proftpd/tls.conf
mv /etc/FTP/modules.conf /etc/proftpd/modules.conf

#Installer openssl
sudo apt install openssl

#Créer un dossier ssl
mkdir /etc/proftpd/ssl

#Générer des clés ssl
sudo echo -en "\n\n\n\n\n\n\n" | openssl req -new -x509 -days 365 -nodes -out /etc/proftpd/ssl/proftpd_rsa.pem -keyout /etc/proftpd/ssl/proftpd_key.pem

#Modifier les droits de la clé proftpd.key.pem
chmod 600 /etc/proftpd/ssl/proftpd_key.pem

#Redémarrer le système 
sudo systemctl restart
