FROM alpine:3.13

WORKDIR /tmp/

# Grafana
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
#RUN apk update && apk add grafana --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN apk upgrade \
	&& apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing grafana grafana-openrc
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
RUN chmod +x ./grafana.sh
ENTRYPOINT ./grafana.sh
