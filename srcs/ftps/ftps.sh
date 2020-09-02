#!/usr/bin/env zsh

rc-service ftps start --extra-config=apiserver.GenericServerRunOptions.ServiceNodePortRange=1000-10000
rc-update add vsftpd
# boucle infinie a refaire
tail -f /dev/null