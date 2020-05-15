#!/bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade

# Docker install
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker vagrant
newgrp docker

# Docker-compose install
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Nodejs install
wget -qO- https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs
sudo ln -s /usr/bin/nodejs /usr/local/bin/nodejs
sudo ln -s /usr/bin/npm /usr/local/bin/npm

# Truffle install
sudo npm install -g --unsafe-perm=true --allow-root truffle

# Prepare the workplace
sudo mkdir /home/vagrant/tezos-workplace
cd /home/vagrant/tezos-workplace
sudo truffle unbox tezos-example

sudo rm -rf /home/vagrant/tezos-workplace/contracts
sudo rm -rf /home/vagrant/tezos-workplace/migrations
sudo rm -rf /home/vagrant/tezos-workplace/test
sudo cp -r /vagrant/contracts /home/vagrant/tezos-workplace/contracts
sudo cp -r /vagrant/migrations /home/vagrant/tezos-workplace/migrations
sudo cp -r /vagrant/test /home/vagrant/tezos-workplace/test

## Test installations
# docker version
# docker-compose version
# npm version
#
## Go to workplace
# cd /home/vagrant/tezos-workplace