#!/bin/bash

printf "\n\n installing keystone.... \n\n"

puppet apply /var/installer/puppet/keystone/keystone.pp

printf "\n\n installing glance.... \n\n"

puppet apply /var/installer/puppet/glance/glance.pp

printf "\n\n installing cinder.... \n\n"

puppet apply /var/installer/puppet/cinder/cinder.pp

printf "\n\n installing quantum.... \n\n"

puppet apply /var/installer/puppet/quantum/openvswitch.pp
puppet apply /var/installer/puppet/quantum/q1.pp
puppet apply /var/installer/puppet/quantum/q2.pp

printf "\n\n installing nova.... \n\n"

puppet apply /var/installer/puppet/nova/kvm.pp
puppet apply /var/installer/puppet/nova/nova.pp

printf "\n\n installing horizon.... \n\n"

puppet apply /var/installer/puppet/horizon/horizon.pp

printf "\n\n immediate reboot recommended !!! \n\n"

exit 0
