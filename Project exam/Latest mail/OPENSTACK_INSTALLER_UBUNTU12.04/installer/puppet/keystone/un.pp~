
import '/var/installer/ref.pp'


mysqlexec::db
{	
	'dropping database':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbname=>keystone,
	ensure=>absent,
}
->
package 
{ 
	'keystone' :
	ensure => purged,
}
->
package 
{ 
	'python-keystone' :
	ensure => purged,
}
->
package 
{ 
	'python-keystoneclient' :
	ensure => purged,
}
->
file 
{ 
   '/etc/environment':
   content => ""
}
