
import '/var/installer/ref.pp'


mysqlexec::db
{	
	'dropping glance database':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbname=>glance,
	ensure=>absent,
}
->
package 
{ 
	'glance':
	ensure => purged,
}
