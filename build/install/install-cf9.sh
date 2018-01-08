#!/bin/sh
#
# Script based on https://forums.adobe.com/message/4727551

/tmp/ColdFusion_9_WWEJ_linux64.bin -f installer.profile

# Disable admin security
/tmp/neo-security-config.sh /opt/coldfusion9 false

# Start up the CF server instance and wait for a moment
/opt/coldfusion9/bin/coldfusion start; sleep 15

# Simulate a browser request on the admin UI to complete installation
wget -O /dev/null http://localhost:8500/CFIDE/administrator/index.cfm?configServer=true

# Stop the CF server instance
/opt/coldfusion9/bin/coldfusion stop

# Re-enable admin security
/tmp/neo-security-config.sh /opt/coldfusion9 true

# updates...
java -jar /tmp/updates/CF902/lib/updates/chf9020001.jar
rm -f /opt/coldfusion9/lib/updates/hf902-00001.jar
rm -f /opt/coldfusion9/lib/updates/hf902-00002.jar
rm -f /opt/coldfusion9/lib/updates/hf902-00003.jar
cp -f /tmp/updates/CF902/lib/*.jar /opt/coldfusion9/lib/
mv -f /tmp/updates/CFIDE /opt/coldfusion9/CFIDE

# Start up the CF server instance and wait for a moment
/opt/coldfusion9/bin/coldfusion start; sleep 15

# Configure Apache2 to run in front of Tomcat
/opt/coldfusion9/runtime/bin/wsconfig -server coldfusion -coldfusion -ws Apache -dir /etc/apache2/ -bin /usr/sbin/apache2 -script /etc/init.d/apache2 -v
