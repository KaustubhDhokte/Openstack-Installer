package 
{ 
	'openvswitch-switch' :
	ensure => installed,
}
->
package
{
	'openvswitch-datapath-dkms' :
	ensure => installed,
}
->
exec
{
	'switch' :
	command=>'/usr/bin/ovs-vsctl add-br br-int'
}
->
exec
{
	'switch2' :
	command=>'/usr/bin/ovs-vsctl add-br br-ex'
}

