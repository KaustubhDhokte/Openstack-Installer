#modules needed : stdlib(included in keystone)

package 
{ 
	'ubuntu-cloud-keyring' :
	ensure => purged,
}
->
package 
{ 
	'python-software-properties' :
	ensure => purged,
}
->
package 
{ 
	'software-properties-common' :
	ensure => purged,
}
->
package 
{ 
	'python-keyring' :
	ensure => purged,
}
->
file 
{ 
	'file for repository':
	path=>'/etc/apt/sources.list.d/grizzly.list',
	ensure => absent,
}
->
package 
{ 
	'python-mysqldb' :
	ensure => purged,
}
->
package 
{ 
	'mysql-server' :
	ensure => purged,
}
->
package 
{ 
	'mysql-client' :
	ensure => purged,
}
->
exec
{
	'mysql_config':
	command=>"/bin/sed -i 's/0.0.0.0/127.0.0.1/g' /etc/mysql/my.cnf"
}
->
package 
{ 
	'rabbitmq-server' :
	ensure => purged,
}
->
package 
{ 
	'ntp' :
	ensure => purged,
}
->
package 
{ 
	'vlan' :
	ensure => purged,
}
->
package 
{ 
	'bridge-utils' :
	ensure => purged,
}
->
exec
{
	'enabling_ip_forward':
	command=>"/bin/sed -i 's/net.ipv4.ip_forward=1/#net.ipv4.ip_forward=1/' /etc/sysctl.conf"
}
->
file 
{ 
'/etc/network/interfaces':
ensure => present,
source => '/var/installer/attach/network/interfaces_old',
}
->
exec
{
	'network-manager':
	command => '/usr/sbin/service network-manager restart'
}

