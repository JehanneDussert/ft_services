#!/bin/sh

export FTP_USERNAME=42user;
export FTP_PASSWORD=42pass;

echo -e "$FTP_PASSWORD\n$FTP_PASSWORD" | adduser -h /mnt/ftp $FTP_USERNAME
ssh-keygen -A
#ftps # lancer le service correctement
#rc-service ftps start
#rc-update add vsftpd
# boucle infinie a refaire
#tail -f /dev/null
supervisord
tail -f /dev/null