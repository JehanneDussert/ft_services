#!/usr/bin/env zsh

rc-service ftps start
# boucle infinie a refaire
tail -f /dev/null