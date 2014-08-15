# What is ColdFusion?
ColdFusion is two things - a server created by Adobe Inc.  This server parses and serves pages written in one of two dialects of ColdFusion - CFML (markup language) and CFSCRIPT (script).

There are some open source competitors to Adobe ColdFusion server such as Railo and BlueDragon.  This container provides a linux based installation of Adobe's ColdFusion Server 10 patched to hotfix version 13.

# How to use this image
```
  docker run --name cf-server-name-of-your-choice -d -p 80:80 -v /var/www:/var/www finalcut/coldfusion10
```

# What odd stuff do I need to know?


1. The admin password for the coldfusion server is `Adm1n$`
2. You can't access the cf-admin interface from the web. You need to use the CF Admin API
3. You can learn more about the coldfusion installation by looking in `./build/install/installer.profile`
