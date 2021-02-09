FROM alpine:3.13

WORKDIR /tmp/

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && apk add influxdb

RUN mkdir -p /etc/influxdb/
RUN mkdir -p /var/log/supervisor/

# Supervisord + telegraf
RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

COPY ./influxdb.conf /etc/influxdb/
COPY ./supervisord.conf /etc/

EXPOSE 8086

COPY influxdb.sh ./influxdb.sh
COPY telegraf.conf /etc/telegraf.conf
RUN chmod +x ./influxdb.sh
ENTRYPOINT ./influxdb.sh
