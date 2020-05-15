#!/bin/bash
sudo rm -rf /home/vagrant/tezos-workplace/contracts
sudo rm -rf /home/vagrant/tezos-workplace/migrations
sudo rm -rf /home/vagrant/tezos-workplace/test
sudo rm /home/vagrant/tezos-workplace/truffle-config.js
sudo cp -r /vagrant/tezos-workplace/contracts /home/vagrant/tezos-workplace/contracts
sudo cp -r /vagrant/tezos-workplace/migrations /home/vagrant/tezos-workplace/migrations
sudo cp -r /vagrant/tezos-workplace/test /home/vagrant/tezos-workplace/test
sudo cp /vagrant/tezos-workplace/truffle-config.js /home/vagrant/tezos-workplace/truffle-config.js