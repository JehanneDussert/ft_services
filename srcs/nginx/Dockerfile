FROM alpine:3.12.0

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

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /www/index.html

COPY nginx.sh ./nginx.sh
RUN chmod +x ./nginx.sh

EXPOSE 80 443