exec 
{ 
	'dprince_qpid':
	command=>'/usr/bin/puppet module install --force dprince-qpid --version 1.0.0',
}
->

exec 
{ 
	'duritong_sysctl':
	command=>'/usr/bin/puppet module install --force duritong-sysctl --version 0.0.4',
}
->



exec 
{ 
	'inifile':
	command=>'/usr/bin/puppet module install --force puppetlabs-inifile --version 1.0.0',
}
->



exec 
{ 
	'pplabs_mysql':
	command=>'/usr/bin/puppet module install --force puppetlabs-mysql --version 0.6.1',
}
->
exec 
{ 
	'rabbitmq':
	command=>'/usr/bin/puppet module install --force puppetlabs-rabbitmq --version 2.0.2',
}
->

exec 
{ 
	'vswitch':
	command=>'/usr/bin/puppet module install --force puppetlabs-vswitch --version 0.1.1',
}

