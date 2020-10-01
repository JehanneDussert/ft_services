#!/bin/sh

sed s/influxdb:8086/localhost:8086/g /etc/telegraf.conf -i

supervisord
