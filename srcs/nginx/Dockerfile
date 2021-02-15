FROM alpine:3.12.3

WORKDIR /tmp

# Installing nginx package
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && apk add nginx openssl openssh-server openrc --no-cache
RUN openrc; touch /run/openrc/softlevel
RUN rc-update add sshd
#RUN sed -i -e "s/rc_parallel="YES"/rc_parallel="FALSE"/g" /etc/rc.conf

RUN mkdir -p /run/nginx/

COPY nginx.conf /etc/nginx/
COPY index.html /var/www/localhost/htdocs/index.html
COPY ./sshd_config /etc/ssh/
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./self-signed.conf /etc/nginx/
RUN rm /etc/nginx/conf.d/default.conf \
	&& chown -R nginx:nginx /var/www/localhost/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=75/L=Paris/O=42/CN=jdussert" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt

RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 80 443

COPY ./nginx.sh .
COPY telegraf.conf /etc/telegraf.conf
RUN chmod +x ./nginx.sh
ENTRYPOINT ./nginx.sh