#!/bin/sh
# no wordpress directory
sed s/__DB_NAME__/$DB_NAME/g /var/www/wordpress/wp-config.php -i
sed s/__DB_USER__/$DB_USER/g /var/www/wordpress/wp-config.php -i
sed s/__DB_PASSWORD__/$DB_PASSWORD/g /var/www/wordpress/wp-config.php -i
sed s/__DB_HOST__/$DB_HOST/g /var/www/wordpress/wp-config.php -i

rm -rf /var/www/html/wordpress
mv /var/www/wordpress/ /var/www/html

# wp core download --path=/var/www/html/wordpress/

# wp core install \
#      --path=/var/www/html/wordpress \
#      --url=localhost:5050 \
#      --title=Title \
#      --admin_user=$DB_USER \
#      --admin_password=$DB_PASSWORD \
#      --admin_email="admin@admin.com"

# wp user create user1 test1@mail.com --role=contributor --path=/var/www/html/wordpress --user_pass=user1
# wp user create user2 test2@mail.com --role=editor --path=/var/www/html/wordpress  --user_pass=user2

supervisord