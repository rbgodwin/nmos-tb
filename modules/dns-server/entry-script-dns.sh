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
sudo chmod 777 /var/cache/bind

#Copy over the configuration files for Bind 9
sudo cp /home/ec2-user/named.conf /etc/bind/named.conf
sudo cp /home/ec2-user/named.conf.local /etc/bind/named.conf.local
sudo cp /home/ec2-user/named.conf.options /etc/bind/named.conf.options
sudo cp /home/ec2-user/named.conf.default-zones /etc/bind/zones/named.conf.default-zones
sudo cp /home/ec2-user/db.root /etc/bind/db.root
sudo cp /home/ec2-user/db.local /etc/bind/db.local
sudo cp /home/ec2-user/db.127 /etc/bind/db.127
sudo cp /home/ec2-user/db.0 /etc/bind/db.0
sudo cp /home/ec2-user/db.255 /etc/bind/db.255


sudo cp /home/ec2-user/db.nmos-tb.org /etc/bind/zones/db.nmos-tb.org
sudo cp /home/ec2-user/db.10 /etc/bind/zones/db.10


# Start up the BIND9 DNS
sudo docker run -it \
        --name=bind9 \
        --publish 53:53/udp \
        --publish 53:53/tcp \
        --publish 127.0.0.1:953:953/tcp \
        --volume /etc/bind:/etc/bind \
        --volume /var/cache/bind:/var/cache/bind \
        --volume /var/lib/bind:/var/lib/bind \
        internetsystemsconsortium/bind9:9.16

 