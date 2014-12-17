#modules needed : stdlib(included in keystone)

package 
{ 
	'ubuntu-cloud-keyring' :
	ensure => installed,
}
->
package 
{ 
	'python-software-properties' :
	ensure => installed,
}
->
package 
{ 
	'software-properties-common' :
	ensure => installed,
}
->
package 
{ 
	'python-keyring' :
	ensure => installed,
}
->
file 
{ 
	'file for repository':
	path=>'/etc/apt/sources.list.d/grizzly.list',
	ensure => 'present',
}
->
file_line 
{ 
	'adding repository':
	path => '/etc/apt/sources.list.d/grizzly.list',
	line => 'deb http://ubuntu-cloud.archive.canonical.com/ubuntu precise-updates/grizzly main',
	ensure=>present,
}
->
exec
{
	'update':
	command=>'/usr/bin/apt-get update',
	logoutput=>true,
}
->
package 
{ 
	'python-mysqldb' :
	ensure => installed,
}
->
package 
{ 
	'mysql-server' :
	ensure => installed,
}
->
package 
{ 
	'mysql-client' :
	ensure => installed,
}
->
exec
{
	'mysql_config':
	command=>"/bin/sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf"
}
->
exec
{
	'restarting mysql':
	command=>'/usr/sbin/service mysql restart'
}
->
package 
{ 
	'rabbitmq-server' :
	ensure => installed,
}
->
package 
{ 
	'ntp' :
	ensure => installed,
}
->
package 
{ 
	'vlan' :
	ensure => installed,
}
->
package 
{ 
	'bridge-utils' :
	ensure => installed,
}
->
exec
{
	'prevent restart':
	command=>'/sbin/sysctl net.ipv4.ip_forward=1'
}
->
exec
{
	'enabling_ip_forward':
	command=>"/bin/sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf"
}
