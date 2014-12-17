exec 
{ 
	'cinder':
	command=>'/usr/bin/puppet module install -f puppetlabs-cinder --version 2.2.0',
}
->
exec 
{ 
	'lvm':
	command=>'/usr/bin/puppet module install -f puppetlabs-lvm --version 0.1.2',
}

