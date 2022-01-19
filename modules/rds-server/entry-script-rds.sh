#!/bin/bash
sudo yum update -y 

#Docker
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

# Easy-nmos docker containers
sudo docker pull rhastie/nmos-cpp:latest
sudo docker run -d --restart unless-stopped -v /tmp/container-config:/home/container-config -v /tmp:/tmp --name RDS --net=host --privileged rhastie/nmos-cpp:latest  
sudo docker run -d --restart unless-stopped -v /tmp/container-config:/home/container-config -v /tmp:/tmp --name Node --env RUN_NODE=TRUE --net=host --privileged rhastie/nmos-cpp:latest  

#AMWA Auto-Tests
sudo docker pull amwa/nmos-testing
sudo docker run -d -p="5000:5000" -v="/tmp/UserConfig.py:/config/UserConfig.py" amwa/nmos-testing