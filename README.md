docker-coldfusion10
===================

ColdFusion 11 as Docker image on Ubuntu 14.04. Run

    ./prepare.sh

first to download ColdFusion 10 installer and latest patches. Then build the Docker container:

    docker build -t cf10 .

And run it with:

    docker run -d -p 80:80 -v /var/www:/var/www cf10



This is entirely based on the work found at https://github.com/naag/docker-coldfusion11
