#!/usr/bin/env zsh

rc-service nginx start
# boucle infinie a refaire
tail -f /dev/null