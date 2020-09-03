mysql
mysql -e "
CREATE DATABASE wordpress;
CREATE USER 'wordpress_user'@'localhost' IDENTIFIED BY '1234';
GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY '1234' WITH GRANT OPTION;
FLUSH PRIVILEGES;"
tail -f /dev/null