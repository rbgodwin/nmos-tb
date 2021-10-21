#!/bin/bash
sudo yum update -y 
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

docker pull rhastie/nmos-cpp:latest
sudo docker run -d --net=host --privileged --rm rhastie/nmos-cpp:latest 
sudo docker run --env RUN_NODE=TRUE -d --net=host --privileged --rm rhastie/nmos-cpp:latest