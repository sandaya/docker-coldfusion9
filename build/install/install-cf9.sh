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


# Apache2 settings
echo "ServerTokens Prod" >> /etc/apache2/conf.d/security
echo "ServerSignature Off" >> /etc/apache2/conf.d/security
echo "TraceEnable Off" >> /etc/apache2/conf.d/security
cat <<EOF >>/etc/apache2/sites-available/cf9
<VirtualHost *:80>    
    ServerAdmin cmecfhelpdesk@mieb.uscourts.gov
    DocumentRoot /var/www
    <Directory /var/www>
        Options -Indexes +FollowSymLinks
        AllowOverride None
        DirectoryIndex index.cfm index.htm index.html
    </Directory>
    LogLevel info
    ErrorLog ${APACHE_LOG_DIR}/error.log    
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
rm -f /etc/apache2/sites-enabled/000-default
ln -sf /etc/apache2/sites-available/cf9 /etc/apache2/sites-enabled/cf9

# Configure Apache2 to run in front of Tomcat
/opt/coldfusion9/runtime/bin/wsconfig -server coldfusion -coldfusion -ws Apache -dir /etc/apache2/ -bin /usr/sbin/apache2 -script /etc/init.d/apache2 -v
