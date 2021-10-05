#!/bin/bash
sudo yum update -y 
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
sudo docker run -d -p 8080:80 nginx 

# Crank up a BIND9 DNS Server for our DNS-SD Needs
sudo docker run -d \
        --name=bind9 \
        --restart=always \
        --publish 53:53/udp \
        --publish 53:53/tcp \
        --publish 127.0.0.1:953:953/tcp \
        --volume /etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --volume /var/log \
        internetsystemsconsortium/bind9:9.16
docker pull rhastie/nmos-cpp:latest
sudo docker run -d --net=host --privileged --rm rhastie/nmos-cpp:latest 
sudo docker run --env RUN_NODE=TRUE -d --net=host --privileged --rm rhastie/nmos-cpp:latest