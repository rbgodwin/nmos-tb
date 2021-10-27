#!/bin/bash
sudo yum update -y 
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

sudo docker pull rhastie/nmos-cpp:latest
sudo docker run -d -v /tmp:/tmp --net=host --privileged --rm rhastie/nmos-cpp:latest  /home/nmos-cpp-registry /tmp/registry.json
sudo docker run -d -v /tmp:/tmp --net=host --privileged --rm rhastie/nmos-cpp:latest /home/nmos-cpp-node /tmp/node.json