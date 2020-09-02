FROM alpine:3.12.0

WORKDIR /tmp

# Installing vsftpd package
RUN apk update
RUN apk add vsftpd
# Utile ?
#RUN apk useradd --system ftps
RUN apk add openrc --no-cache

# Creating directory
RUN mkdir /srv/ftps
RUN chown -R nobody.nogroup /srv/ftps
RUN echo "jdussert" > /srv/ftps/user.txt

COPY vsftpd.conf /etc/ftps/vsftpd.conf

COPY ftps.sh ./ftps.sh
RUN chmod +x ./ftps.sh
CMD sh ./ftps.sh

EXPOSE 21 21000
