#!/bin/bash
sudo yum update -y 
sudo yum install -y bind bind-utils

#Copy over the configuration files for Bind 9
sudo cp /home/ec2-user/named.conf /etc
sudo cp /home/ec2-user/db.nmos-tb.org /var/named/

#Start up the BIND9 DNS
sudo systemctl enable named
sudo systemctl start named

#Wireguard
#install Wireguard
sudo curl -L -o /etc/yum.repos.d/wireguard.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo
sudo amazon-linux-extras install -y epel
sudo yum install -y wireguard-dkms wireguard-tools


# Copy over our Wireguard VPN public and private keys
sudo cp /home/ec2-user/publickey /etc/wireguard
sudo cp /home/ec2-user/privatekey /etc/wireguard
sudo cp /home/ec2-user/wg0.conf /etc/wireguard

#start it up
sudo wg-quick up wg0

# Setup a route to get to the 172.17.0.0/24 network attached to the RDS 
sudo ip route add 172.17.0.0/16 via 10.0.50.77

