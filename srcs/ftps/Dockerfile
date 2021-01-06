FROM alpine:3.12.3

WORKDIR /tmp

# Installing vsftpd package
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update
RUN apk add openssl vsftpd
#RUN apk add openrc --no-cache

COPY ./vsftpd.conf /etc/vsftpd/
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./ftps-selfsigned.conf /etc/ftps/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=75/L=Paris/O=42/CN=192.168.99.101" \
	-keyout /etc/ssl/private/ftps-selfsigned.key \
	-out /etc/ssl/certs/ftps-selfsigned.crt

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

EXPOSE 21 30000

VOLUME /mnt/ftps-data

COPY ftps.sh ./ftps.sh
RUN chmod +x ./ftps.sh
ENTRYPOINT ./ftps.sh