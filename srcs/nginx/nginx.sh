#!/usr/bin/env zsh

export user=username;
export user_pass=;

adduser -D ${user};
echo "user:user_pass" | chpasswd
ssh-keygen -A
nginx -g "daemon off;"
#rc-service nginx start
# boucle infinie a refaire
tail -f /dev/null