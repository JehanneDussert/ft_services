FROM alpine:3.12.0

WORKDIR /tmp

# Installing nginx package
RUN apk update
RUN apk add nginx
RUN apk add openrc --no-cache

# Creating user and home director for nginx server
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN mkdir -p /run/nginx

# Creating SSH user && SSL key
RUN adduser -D user
RUN apk add --no-cache openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=75/L=Paris/O=42/CN=jdussert" \
	-keyout /tmp/server.key \
	-out /tmp/server.crt
#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout \
#/etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /www/index.html

COPY nginx.sh ./nginx.sh
RUN chmod +x ./nginx.sh
CMD sh ./nginx.sh

EXPOSE 80 443