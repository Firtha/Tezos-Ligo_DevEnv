#!/bin/bash
sudo rm -rf /home/vagrant/tezos-workplace/contracts
sudo rm -rf /home/vagrant/tezos-workplace/migrations
sudo rm -rf /home/vagrant/tezos-workplace/test
sudo cp -r /vagrant/contracts /home/vagrant/tezos-workplace/contracts
sudo cp -r /vagrant/migrations /home/vagrant/tezos-workplace/migrations
sudo cp -r /vagrant/test /home/vagrant/tezos-workplace/test