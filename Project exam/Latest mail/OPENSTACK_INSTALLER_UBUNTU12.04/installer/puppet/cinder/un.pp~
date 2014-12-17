
import '/var/installer/ref.pp'


file_line 
{ 
	'un_care_reboot':
	path => '/etc/rc.local',
	line => 'losetup /dev/loop2 /var/openstack/cinder/cinder-volumes',
	ensure=> absent,
}
->
exec 
{ 
	'deleting volumes':
	command=>"/bin/rm -rf /var/openstack/cinder/cinder-volumes",
}

/*
volume_group
{
	'cinder-volumes':
	ensure=>absent,
	physical_volumes=>'/dev/loop2'	
}
->

physical_volume
{
	'/dev/loop2':
	ensure=>absent,
}
*/
->
mysqlexec::db
{	
	'dropping database':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbname=>cinder,
	ensure=>absent,
}
->
package 
{ 
	'iscsitarget-dkms' :
	ensure => purged,
}
->
package 
{ 
	'open-iscsi' :
	ensure => purged,
}
->
package 
{ 
	'iscsitarget' :
	ensure => purged,
}
->
package 
{ 
	'cinder-volume' :
	ensure => purged,
}
->
package 
{ 
	'cinder-scheduler' :
	ensure => purged,
}
->
package 
{ 
	'cinder-api' :
	ensure => purged,
}
->
package 
{ 
	'python-cinderclient' :
	ensure => purged,
}


exec 
{ 
	'unmounting':
	command=>'/sbin/losetup -d /dev/loop2 ',
}

