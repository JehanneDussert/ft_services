#!/bin/sh

sed s/__DB_HOST__/$DB_HOST/g /var/www/phpmyadmin/config.inc.php -i

supervisord
