
import '/var/installer/ref.pp'




package 
{ 
	'libvirt-bin' :
	ensure => purged,
}
->
package 
{ 
	'kvm' :
	ensure => purged,
}
->
package 
{ 
	'pm-utils' :
	ensure => purged,
}
->
package 
{ 
	'nova-api' :
	ensure => purged,
}
->
package 
{ 
	'nova-cert' :
	ensure => purged,
}
->
package 
{ 
	'novnc' :
	ensure => purged,
}
->
package 
{ 
	'nova-consoleauth' :
	ensure => purged,
}
->
package 
{ 
	'nova-scheduler' :
	ensure => purged,
}
->
package 
{ 
	'nova-novncproxy' : 
	ensure => purged,
}
->
package 
{ 
	'nova-doc' :
	ensure => purged,
}
->
package 
{ 
	'nova-conductor' :
	ensure => purged,
}
->
package 
{ 
	'nova-compute-kvm' : 
	ensure => purged,
}
->
mysqlexec::db
{	
	'dropping database':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbname=>nova,
	ensure=>absent,
}

