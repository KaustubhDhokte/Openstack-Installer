#!/bin/bash

printf "\n\n installing puppet.... \n\n"

dpkg -i /var/installer/attach/puppetlabs-release-precise.deb
sudo apt-get update
sudo apt-get -y install puppet-common=3.4.2-1puppetlabs1

printf "\n\n puppet installed successfully with version no.:"
puppet --version

printf "\n\n setting up initial configuration.... \n\n"

puppet apply /var/installer/puppet/iniconfig/mod.pp
puppet apply /var/installer/puppet/iniconfig/iniconfig.pp

puppet apply /var/installer/puppet/keystone/mod.pp
puppet apply /var/installer/puppet/glance/mod.pp
puppet apply /var/installer/puppet/cinder/mod.pp
puppet apply /var/installer/puppet/quantum/mod.pp
puppet apply /var/installer/puppet/nova/mod.pp
puppet apply /var/installer/puppet/dep.pp
puppet apply /var/installer/puppet/iniconfig/iniconfig_net.pp

exit 0
