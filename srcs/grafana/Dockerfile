FROM  alpine:3.12.0

WORKDIR /tmp/

RUN apk update && apk add grafana --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing


# Supervisord + telegraf
RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

COPY ./supervisord.conf /etc/
COPY ./grafana.ini /usr/share/grafana/conf/custom.ini

EXPOSE 3000

COPY grafana.sh ./grafana.sh
RUN chmod +x ./grafana.sh
ENTRYPOINT ./grafana.sh
