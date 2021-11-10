#!/bin/bash
sudo yum update -y 
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

sudo docker pull rhastie/nmos-cpp:latest
sudo docker run -d -v /tmp/container-config:/home/container-config -v /tmp:/tmp --name RDS --net=host --privileged --rm rhastie/nmos-cpp:latest  
sudo docker run -d -v /tmp/container-config:/home/container-config -v /tmp:/tmp --name Node --env RUN_NODE=TRUE --net=host --privileged --rm rhastie/nmos-cpp:latest  
