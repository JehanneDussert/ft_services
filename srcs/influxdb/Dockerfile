FROM alpine:3.12.0

WORKDIR /tmp/

RUN apk update && apk install influxdb

RUN mkdir -p /etc/influxdb/
RUN mkdir -p /var/log/supervisor/

# Supervisord + telegraf
RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

COPY ./influxdb.conf /etc/influxdb/
COPY ./supervisord.conf /etc/

EXPOSE 8086

COPY ./influxdb.sh .
RUN chmod +x influxdb.sh
ENTRYPOINT influxdb.sh
