mysql_install_db --datadir=/var/lib/nysql

mysqld

mysql -e "
CREATE DATABASE ${DB_NAME};
CREATE USER ${DB_USER} IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL ON ${DB_NAME}.* TO ${DB_USER} IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

supervisord
#tail -f /dev/null