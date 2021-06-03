FROM alpine:3.12.3

#update and install utils
RUN apk update
RUN apk add influxdb
RUN apk add openrc
RUN rc-status
RUN touch /run/openrc/softlevel

#telegraf
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add telegraf
RUN mkdir /etc/telegraf 
ADD srcs/telegraf.conf /etc/telegraf/

#Add conf
RUN mkdir /etc/influxdb
ADD ./srcs/influxdb.conf /etc/influxdb/influxdb.conf
ADD ./srcs/setup.sh . 
RUN chmod 777 setup.sh

EXPOSE 8086

#CMD		[ "/bin/ash", "setup.sh" ]