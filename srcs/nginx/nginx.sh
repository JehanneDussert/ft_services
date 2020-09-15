#!/usr/bin/env sh

export user=username;
export user_pass=;

adduser -D ${user};
echo "$user:$user_pass" | chpasswd
ssh-keygen -A
supervisord
#nginx -g "daemon off;"
#rc-service nginx start
# boucle infinie a refaire
tail -f /dev/null