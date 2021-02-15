#!/usr/bin/env sh

export user=username;
export user_pass=;

adduser -D ${user};
echo "$user:$user_pass" | chpasswd
ssh-keygen -A
supervisord
tail -f /dev/null