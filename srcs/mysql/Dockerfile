FROM alpine:3.12.0

WORKDIR /tmp

RUN apk update && apk upgrade

# Install wget
RUN apk add wget

# Installing MySQL packaging
RUN apk add mariadb-dev

COPY mysql.sh ./mysql.sh
RUN chmod +x ./mysql.sh
CMD sh ./mysql.sh

EXPOSE 5050