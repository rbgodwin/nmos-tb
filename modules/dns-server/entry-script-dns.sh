#!/bin/bash
sudo yum update -y 
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
sudo yum install -y bind bind-utils


#Copy over the configuration files for Bind 9
sudo cp /home/ec2-user/named.conf /etc
sudo cp /home/ec2-user/db.nmos-tb.org /var/named/

#Start up the BIND9 DNS
sudo systemctl enable named
sudo systemctl start named