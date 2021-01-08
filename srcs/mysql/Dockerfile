FROM alpine:3.12.3

WORKDIR /tmp

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && apk add mariadb mariadb-common mariadb-client openrc --no-cache

COPY ./supervisord.conf /etc/
COPY ./my.cnf /etc/my.cnf.d/mariadb-server.cnf
# COPY ./users.sql .
# COPY ./wordpress.sql .

sRUN rmdir /var/lib/mysql/
RUN mkdir -p /var/log/supervisor/

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

EXPOSE 3306

COPY mysql.sql ./mysql.sql
COPY mysql.sh ./mysql.sh
RUN chmod +x ./mysql.sh
ENTRYPOINT ./mysql.sh
