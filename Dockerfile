FROM phusion/baseimage:0.9.9
MAINTAINER pressrelations
EXPOSE 80 8500
VOLUME ["/var/www", "/tmp/config"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y wget unzip xsltproc apache2
ADD ./build/install/ /tmp/
ADD ./build/service/ /etc/service/
ADD ./build/my_init.d/ /etc/my_init.d/
ADD ./source/index.cfm /tmp/source/
RUN chmod 755 /tmp/install-cf10.sh
RUN chmod -R 755 /build/service/
RUN sudo /tmp/install-cf10.sh
RUN mv /tmp/source/index.cfm /var/www/.
