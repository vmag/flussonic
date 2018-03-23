# FLUSSONIC
#
# VERSION               4.7.3

FROM      debian:wheezy
MAINTAINER Virginijus Magelinskas <virginijus.m@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# make sure the package repository is up to date
RUN apt-get update -y && \
apt-get install -y wget supervisor apt-utils && \
wget -q -O - http://debian.erlyvideo.org/binary/gpg.key | apt-key add - && \
echo "deb http://debian.erlyvideo.org binary/" > /etc/apt/sources.list.d/erlyvideo.list && \
apt-get update -y && \
apt-get -y install flussonic flussonic-ffmpeg && \
apt-get upgrade -y
ADD supervisord.conf /etc/supervisord.conf 
RUN mkdir -p /var/log/supervisor
VOLUME ["/etc/flussonic", "/var/run/flussonic", "/var/log/flussonic", "/mnt" ]
EXPOSE 80 81 443 554/udp 1935 3306 8080
CMD ["/usr/bin/supervisord"]


