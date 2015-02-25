FROM phusion/baseimage:0.9.9
EXPOSE 80 8500
VOLUME ["/var/www", "/tmp/config"]

ENV DEBIAN_FRONTEND noninteractive
ENV REFRESHED_AT 2015_02_23_1

RUN apt-get update
RUN apt-get install -y wget unzip xsltproc apache2 default-jre && apt-get clean

ADD ./build/install/ /tmp/

RUN chmod 755 /tmp/ColdFusion_9_WWEJ_linux64.bin
RUN chmod 755 /tmp/install-cf9.sh
RUN sudo /tmp/install-cf9.sh

# Replace the default startup script with a slightly modified one which logs to console
RUN mv /tmp/coldfusion /opt/coldfusion9/bin/coldfusion

ADD ./build/service/ /etc/service/
RUN chmod -R 755 /etc/service/coldfusion9

ADD ./build/my_init.d/ /etc/my_init.d/

RUN rm /tmp/*.bin
RUN rm /tmp/*.sh
