docker-coldfusion10
===================

ColdFusion 10 as Docker image on Ubuntu 14.04.

If you are on a VM or something and you need to download the coldfusion binary and patch files from a local file server update prepare.sh and then run it.

    ./prepare.sh

Once you have the CF binary and patches in the /install/build direcotry you can build the Docker container:

    docker build -t cf10 .

And run it with:

    docker run -d -p 8880:80 -v /var/www:/var/www cf10



This is entirely based on the work found at https://github.com/naag/docker-coldfusion11

The silent installation of ColdFusion is accomplished with a ./build/install/installer.profile file. The syntax for that file is described in this [Adobe blog post](: http://blogs.adobe.com/cfdoc/2009/10/performing_a_silent_installation_of_coldfusion_9.html).


The CF installation script was written by Jan Ruusuvuori and seems to only exist in this [forum post](https://forums.adobe.com/message/4721871).  I just updated that script to include the installation of the hotfixes.

Finally, I map port 80 on the CF server to port 8880 and I have it in the usage instructions here to make it easier for me to copy paste.  Use whatever port mapping works for you.
