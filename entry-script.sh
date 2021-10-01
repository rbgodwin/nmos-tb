#!/bin/bash
sudo yum update -y 
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
docker run -p 8080:80 nginx
docker pull rhastie/nmos-cpp:latest
docker run -it --net=host --privileged --rm rhastie/nmos-cpp:latest