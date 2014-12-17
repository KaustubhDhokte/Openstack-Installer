#!/bin/bash

printf "\n\n removing horizon.... \n\n"

puppet apply /var/installer/puppet/horizon/un.pp

printf "\n\n removing nova.... \n\n"

puppet apply /var/installer/puppet/nova/un.pp

printf "\n\n removing quantum.... \n\n"

puppet apply /var/installer/puppet/quantum/un.pp

printf "\n\n removing cinder.... \n\n"

puppet apply /var/installer/puppet/cinder/un.pp

printf "\n\n removing glance.... \n\n"

puppet apply /var/installer/puppet/glance/un.pp

printf "\n\n removing keystone.... \n\n"

puppet apply /var/installer/puppet/keystone/un.pp

exit 0
