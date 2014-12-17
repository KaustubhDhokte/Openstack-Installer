package 
{ 
	'openstack-dashboard' :
	ensure => installed,
}
->
package 
{ 
	'memcached' :
	ensure => installed,
}
->
exec 
{ 
	'restart_apache':
	command=>'/usr/sbin/service apache2 restart',
}
->
exec 
{ 
	'restart_memcached':
	command=>'/usr/sbin/service memcached restart',
}




