#!/usr/bin/env zsh

rc-update add sshd default
rc-service nginx start
# boucle infinie a refaire
tail -f /dev/null