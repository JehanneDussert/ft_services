FROM alpine:3.12.0

WORKDIR /tmp

# Installing nginx package
RUN apk update && apk add nginx openssl openssh-server openrc --no-cache
RUN openrc; touch /run/openrc/softlevel
RUN rc-update add sshd
RUN mkdir -p /run/nginx/

# Creating user and home director for nginx server
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www

COPY nginx.conf /etc/nginx/
COPY index.html /www/index.html
COPY ./sshd_config /etc/ssh/

# Creating SSH user && SSL key
# Faire une cle SSH en plus keygen
RUN adduser -D user
RUN user=user;
#RUN user_pass =user_pass;
RUN echo "user:user_pass" | chpasswd
RUN ssh-keygen -A
#RUN apk add --no-cache openssl
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=75/L=Paris/O=42/CN=jdussert" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt
#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout \
#/etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

COPY nginx.sh ./nginx.sh
RUN chmod +x ./nginx.sh
CMD sh ./nginx.sh

VOLUME [ “/sys/fs/cgroup” ]

EXPOSE 80 443 22