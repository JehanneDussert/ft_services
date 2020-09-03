FROM alpine:3.12.0

WORKDIR /tmp

#RUN apk update

# Installing wordpress packaging
RUN wget https://wordpress.org/latest.tar.gz -P /tmp && \
    mkdir /var/www/html/wordpress && \
    tar xzf /tmp/latest.tar.gz --strip-components=1 -C /var/www/html/wordpress
ADD /srcs/wordpress_config.php /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress

COPY wordpress.sh ./wordpress.sh
RUN chmod +x ./wordpress.sh
CMD sh ./wordpress.sh

EXPOSE 5050