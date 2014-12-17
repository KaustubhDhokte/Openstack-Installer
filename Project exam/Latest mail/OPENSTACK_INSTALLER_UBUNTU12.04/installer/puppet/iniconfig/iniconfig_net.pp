file
{
	"/var/openstack":
	ensure=>"directory",
}
->
file
{
	"/var/openstack/network":
	ensure=>"directory",
}
->
file 
{ 
'/var/openstack/network/interfaces':
ensure => present,
source => '/etc/network/interfaces',
}
->
file 
{ 
'/etc/network/interfaces':
ensure => present,
source => '/var/installer/attach/network/interfaces',
}
->
exec
{
	'network-manager':
	command => '/usr/sbin/service network-manager restart'
}

