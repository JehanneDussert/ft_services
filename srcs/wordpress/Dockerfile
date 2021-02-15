FROM alpine:3.12.3

WORKDIR /tmp

# Nginx
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && apk add --no-cache nginx \
	&& apk add openssl \
	&& apk add php7-fpm php7-mbstring php7-session php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=FR/ST=75/L=Paris/O=42/CN=localhost" -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

RUN apk add --no-cache  --repository http://dl-cdn.alpinelinux.org/alpine/edge/community php \
	&& apk add mysql-client
RUN php -v

RUN mkdir -p /run/nginx/

# Installing wordpress packaging
ARG VERSION="wordpress-5.5"
ARG WP_FILE="${VERSION}.tar.gz"
RUN wget https://wordpress.org/${WP_FILE} && \
	tar -xf ${WP_FILE} && \
	mv wordpress /var/www/ && \
	rm -rf ${WP_FILE}

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./wordpress_config.php /var/www/wordpress/wp-config.php
COPY ./supervisord.conf /etc/
# RUN chown -R www-data:www-data /var/www/html/wordpress/

EXPOSE 5050

COPY wordpress.sh ./wordpress.sh
COPY telegraf.conf /etc/telegraf.conf
RUN chmod +x ./wordpress.sh
CMD sh ./wordpress.sh