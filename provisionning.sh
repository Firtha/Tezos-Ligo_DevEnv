#!/bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade

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

sudo mkdir /home/vagrant/tezos-workplace/utils-vagrant
sudo cp /vagrant/exportWorkFolders.sh /home/vagrant/tezos-workplace/utils-vagrant/exportWorkFolders.sh
sudo cp /vagrant/importWorkFolders.sh /home/vagrant/tezos-workplace/utils-vagrant/importWorkFolders.sh

# Test installations
# docker version
# docker-compose version
# npm version