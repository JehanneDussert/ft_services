FROM alpine:3.13

WORKDIR /tmp/

# User=jdussert ; Password=password

# Grafana
RUN apk upgrade \
	&& apk add grafana grafana-openrc

# Supervisord + telegraf
RUN apk update && apk upgrade && apk add --no-cache vim supervisor wget curl && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

RUN mkdir -p /var/log/supervisor/

COPY ./supervisord.conf /etc/
COPY ./grafana.ini /usr/share/grafana/conf/custom.ini
COPY ./dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/
COPY ./influxdb.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY ./dashboards /var/lib/grafana/dashboards/

EXPOSE 3000

COPY grafana.sh ./grafana.sh
COPY telegraf.conf ./telegraf.conf
RUN chmod +x ./grafana.sh
ENTRYPOINT ./grafana.sh
