#!/bin/bash
sudo yum update -y 
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

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
