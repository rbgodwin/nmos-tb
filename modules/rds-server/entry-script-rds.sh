#!/bin/bash
sudo yum update -y 

#Docker
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

# Allow forwarding onto the docker interface 
sudo iptables -I DOCKER-USER -i eth0 -o docker0 -j ACCEPT
# Easy-nmos docker containers
sudo docker pull rhastie/nmos-cpp:latest
sudo docker run -d --restart unless-stopped -p 8010:8010 -p 8011:8011 -v /tmp/container-config:/home/container-config -v /tmp:/tmp --name RDS  rhastie/nmos-cpp:latest  
sudo docker run -d --restart unless-stopped -v /tmp/container-config:/home/container-config -v /tmp:/tmp --name Node --env RUN_NODE=TRUE rhastie/nmos-cpp:latest  

#AMWA Auto-Tests
sudo docker pull amwa/nmos-testing
sudo docker run -d --restart unless-stopped -p 5000:5000 -p 5001:5001 -v="/tmp/UserConfig.py:/config/UserConfig.py" --name NMOS-TESTING amwa/nmos-testing

# Go through our off-cloud gateways (10.0.59.0/24 via wireguard server) 
sudo ip route add 10.0.59.0/24 via 10.0.50.59

#Add in routes for on premise deployed subnets via wireguard Server 
sudo ip route add 192.168.14.0/24 via 10.0.50.59
sudo ip route add 192.168.15.0/24 via 10.0.50.59
