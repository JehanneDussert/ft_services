FROM alpine:3.13

WORKDIR /tmp

EXPOSE 5050

# Nginx
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update \
	&& mkdir -p /run/nginx \
	&& apk add nginx \
	&& apk add openssl \
	&& apk add php7-fpm php7-mbstring php7-session php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=75/L=Paris/O=42/CN=jdussert" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt

# Installing wordpress
COPY WordPress /var/www/localhost/wordpress
COPY nginx.conf /etc/nginx/conf.d/localhost.conf
RUN rm /etc/nginx/conf.d/default.conf \
&& chown -R nginx:nginx /var/www/localhost/wordpress

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

COPY ./supervisord.conf /etc/

COPY wordpress.sh ./wordpress.sh
COPY telegraf.conf /etc/telegraf.conf
RUN chmod +x ./wordpress.sh
CMD sh ./wordpress.sh