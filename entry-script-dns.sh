#!/bin/bash
sudo yum update -y 
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

#Setup needed folders for bind
sudo mkdir /etc/bind
sudo mkdir /etc/bind/zones
sudo mkdir /var/lib/bind
sudo mkdir /var/cache/bind

#Copy over the configuration files for Bind 9
sudo cp /home/ec2-user/db.gplab.com /etc/bind/zones
sudo cp /home/ec2-user/named.conf /etc/bind/named.conf

# Start up the BIND9 DNS
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
