#!/bin/bash

printf "\n\n removing initial configuration.... \n\n"

apt-get update

puppet apply /var/installer/puppet/iniconfig/un.pp

rm -rf /var/openstack

printf "\n\n removing puppet.... \n\n"

rm puppetlabs-release-precise.deb
sudo apt-get -y purge puppet
sudo apt-get -y autoremove

exit 0
