#!/bin/bash
sudo rm -rf /vagrant/tezos-workplace
mkdir /vagrant/tezos-workplace
sudo cp -r /home/vagrant/tezos-workplace/contracts /vagrant/tezos-workplace/contracts
sudo cp -r /home/vagrant/tezos-workplace/migrations /vagrant/tezos-workplace/migrations
sudo cp -r /home/vagrant/tezos-workplace/test /vagrant/tezos-workplace/test
sudo cp /home/vagrant/tezos-workplace/truffle-config.js /vagrant/tezos-workplace/truffle-config.js