FROM alpine:3.12.0

WORKDIR /tmp

RUN apk update && apk upgrade
RUN apk add mariadb mariadb-common mariadb-client openrc --no-cache

#RUN apk add mariadb-dev

COPY ./supervisord.conf /etc/

RUN rmdir /var/lib/mysql/
RUN mkdir -p /var/log/supervisor/

EXPOSE 3306

COPY mysql.sh ./mysql.sh
RUN chmod +x ./mysql.sh
ENTRYPOINT ./mysql.sh