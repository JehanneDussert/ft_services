FROM alpine:3.12.0

WORKDIR /tmp

# Nginx
RUN apk update && apk upgrade
RUN apk add nginx
# Php 7
RUN apk add php7 php7-fpm php7-opcache
# Php 7 modules
RUN apk add php7-gd php7-mysqli php7-zlib php7-curl

ARG VERSION="phpMyAdmin-5.0.2-all-languages"
RUN wget http://files.directadmin.com/services/all/phpMyAdmin/${VERSION}.tar.gz && \
	tar -xf ${VERSION}.tar.gz && \
	mv ${VERSION} /var/www/phpmyadmin && \
	rm -rf ${VERSION}

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl

RUN mkdir -p /run/nginx/

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./phpma_config.php /var/wwww/phpmyadmin/config.sample.inc.php

EXPOSE 5000

COPY ./phpmyadmin.sh .
RUN chmod +x ./phpmyadmin.sh
ENTRYPOINT ./phpmyadmin.sh