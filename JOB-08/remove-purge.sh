#!/bin/bash

# Desinstaller le service  proftpd et le  ssl

sudo apt --purge remove proftpd-*
rm /etc/proftpd/ssl/proftpd.cert.pem 
rm /etc/proftpd/ssl/proftp.key.pem

# Supprimer les deux utilisateurs

sudo userdel -r Merry && sudo userdel -r Pippin
