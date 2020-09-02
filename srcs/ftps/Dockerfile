FROM alpine:3.12.0

WORKDIR /tmp

# Installing nginx package
RUN apk update
RUN apk add vsftpd
RUN apk add openrc --no-cache

COPY ftps.conf /etc/ftps/ftps.conf

COPY ftps.sh ./ftps.sh
RUN chmod +x ./ftps.sh
CMD sh ./ftps.sh

EXPOSE 21 21000
