#!/bin/sh

mysql_install_db --ldata=/var/lib/mysql
sleep 5
mysqld --default-authentication-plugin=mysql_native_password &
sleep 5
#mysqld
tmpsql="/tmp/init_sql"
echo > $tmpsql \
"CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS ${DB_USER} IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
GRANT ALL ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

if [ ! -f /var/lib/mysql/wpNewUsers ]; then
	echo "done" >> /var/lib/mysql/wpNewUsers
	mysql -h localhost -e "$(cat $tmpsql)"
	mysql -h localhost -e "$(cat ./mysql.sql)"
	mysql -h localhost -e "$(cat ./users.sql)"
fi

rm -f $tmpsql

/usr/share/mariadb/mysql.server stop

supervisord
