#!/bin/sh

export FTP_USERNAME=42user;
export FTP_PASSWORD=42pass;

echo -e "$FTP_PASSWORD\n$FTP_PASSWORD" | adduser -h /mnt/ftp $FTP_USERNAME
mkdir -p /mnt/ftp/doss
echo "file" > /mnt/ftp/doss/file
supervisord
#tail -f /dev/null