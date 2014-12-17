
import '/var/installer/ref.pp'


package 
{ 
	'openvswitch-switch' :
	ensure => purged,
}
->
package
{
	'openvswitch-datapath-dkms' :
	ensure => purged,
}
->
package 
{ 
	'quantum-server' :
	ensure => purged,
}
->
package 
{ 
	'quantum-plugin-openvswitch' :
	ensure => purged,
}
->
package 
{ 
	'quantum-plugin-openvswitch-agent' :
	ensure => purged,
}
->
package 
{ 
	'dnsmasq' :
	ensure => purged,
}
->
package 
{ 
	'quantum-l3-agent' :
	ensure => purged,
}
->
package 
{ 
	'quantum-dhcp-agent' :
	ensure => purged,
}
->
mysqlexec::db
{	
	'dropping database':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbname=>quantum,
	ensure=>absent,
}

