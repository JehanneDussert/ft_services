#!/usr/bin/env zsh

ftps # lancer le service correctement
#rc-service ftps start
#rc-update add vsftpd
# boucle infinie a refaire
tail -f /dev/null
supervisord