FROM alpine

RUN apk update
RUN apk add nginx

RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /www/index.html

RUN rc-service nginx start
EXPOSE 80
EXPOSE 443