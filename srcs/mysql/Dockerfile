FROM alpine:3.12.0

WORKDIR /tmp

RUN apk update -y && apk upgrade -y

# Install wget
RUN apk -y install wget

# Installing MySQL packaging
RUN apk -y install mariadb-server

COPY mysql.sh ./mysql.sh
RUN chmod +x ./mysql.sh
CMD sh ./mysql.sh

EXPOSE 5050