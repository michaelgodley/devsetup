#!/bin/bash

# source some env variables
. ../config.conf
source ./libs.sh

# Install Docker and Docker Compose

for pkg in docker docker-engine docker-ce docker.io docker-doc docker-compose podman-docker containerd runc; 
     do aptremove $pkg; 
done

sudo apt update
aptinstall apt-transport-https
aptinstall ca-certificates 
aptinstall curl
aptinstall software-properties-common
aptinstall gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
aptinstall docker-ce 
aptinstall docker-ce-cli 
aptinstall containerd.io 
aptinstall docker-buildx-plugin 
aptinstall docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker $USER

# Non Prod
#curl -fsSL https://get.docker.com -o get-docker.sh
#sudo sh get-docker.sh

## Old way
#aptremove docker
#aptremove docker-engine
#aptremove docker.io
#aptremove docker-ce
#aptremove containerd
#aptremove runc
#sudo apt update
#aptinstall apt-transport-https
#aptinstall ca-certificates 
#aptinstall curl
#aptinstall software-properties-common
#aptinstall gnupg-agent
#curl -fsSL http://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository \
#     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#     $(lsb_release -cs) \
#     stable" 
#sudo apt update
#aptinstall docker-ce
#aptinstall docker-ce-cli
#aptinstall containerd.io
#sudo groupadd docker
#sudo usermod -aG docker $USER

# Install Docker Compose
#sudo rm /usr/local/bin/docker-compose 
#sudo curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

