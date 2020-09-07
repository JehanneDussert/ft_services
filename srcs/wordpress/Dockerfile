FROM alpine:3.12.0

WORKDIR /tmp

RUN apk update && apk upgrade
RUN apk add php7 php7-fpm php7-opcache php7-gd \
    php7-mysqli php7-zlib php7-curl php7-mbstring \
    php7-json php7-session
# Install wget
RUN apk add wget

# Installing wordpress packaging
RUN wget https://wordpress.org/latest.tar.gz -P /tmp && \
    mkdir -p /var/www/html/wordpress && \
    tar xzf /tmp/latest.tar.gz --strip-components=1 -C /var/www/html/wordpress
COPY ./wordpress_config.php /var/www/html/wordpress/
# RUN chown -R www-data:www-data /var/www/html/wordpress/

COPY wordpress.sh ./wordpress.sh
RUN chmod +x ./wordpress.sh
CMD sh ./wordpress.sh

EXPOSE 5050