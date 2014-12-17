
#modules : quantum

exec
{
	'update':
	command=>'/usr/bin/apt-get update',	
}
->
package 
{ 
	'quantum-server' :
	ensure => installed,
}
->
package 
{ 
	'quantum-plugin-openvswitch' :
	ensure => installed,
}
->
package 
{ 
	'quantum-plugin-openvswitch-agent' :
	ensure => installed,
}
->
package 
{ 
	'dnsmasq' :
	ensure => installed,
}
->
package 
{ 
	'quantum-l3-agent' :
	ensure => installed,
}
->
package 
{ 
	'quantum-dhcp-agent' :
	ensure => installed,
}
