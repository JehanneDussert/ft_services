FROM alpine:3.12.0

WORKDIR /tmp

# Nginx
RUN apk update && apk upgrade
RUN apk add nginx

RUN apk add php7 php7-fpm php7-opcache php7-gd \
    php7-mysqli php7-zlib php7-curl php7-mbstring \
    php7-json php7-session

# Install wget
RUN apk add wget

# Installing wordpress packaging
ARG VERSION="wordpress-5.5"
ARG WP_FILE="${VERSION}.tar.gz"
RUN wget https://wordpress.org/${WP_FILE} && \
	tar -xf ${WP_FILE} && \
	mv wordpress /var/www/ && \
	rm -rf ${WP_FILE}

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl

RUN mkdir -p /run/nginx/

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./wordpress_config.php /var/www/html/wordpress/
# RUN chown -R www-data:www-data /var/www/html/wordpress/

COPY wordpress.sh ./wordpress.sh
RUN chmod +x ./wordpress.sh
CMD sh ./wordpress.sh

EXPOSE 5050