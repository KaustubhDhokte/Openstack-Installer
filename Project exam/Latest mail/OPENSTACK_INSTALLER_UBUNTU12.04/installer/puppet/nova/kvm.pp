#modules needed : editfile

package 
{ 
	'kvm' :
	ensure => installed,
}
->
package 
{ 
	'libvirt-bin' :
	ensure => installed,
}
->
package 
{ 
	'pm-utils' :
	ensure => installed,
}
->
file
{   
	"/var/openstack":
	ensure => "directory",
}
->
file
{   
	"/var/openstack/libvirt":
	ensure => "directory",
}
->
file 
{ 
'/var/openstack/libvirt/qemu.conf':
ensure => present,
source => '/etc/libvirt/qemu.conf',
}
->

file_line 
{ 
	'cgroup_device_acl1':
	path => '/etc/libvirt/qemu.conf',
	line => "cgroup_device_acl = [
\"/dev/null\", \"/dev/full\", \"/dev/zero\",
\"/dev/random\", \"/dev/urandom\",
\"/dev/ptmx\", \"/dev/kvm\", \"/dev/kqemu\",
\"/dev/rtc\", \"/dev/hpet\",\"/dev/net/tun\"
]",
	ensure=>absent,
}

->

file_line 
{ 
	'cgroup_device_acl':
	path => '/etc/libvirt/qemu.conf',
	line => "cgroup_device_acl = [
\"/dev/null\", \"/dev/full\", \"/dev/zero\",
\"/dev/random\", \"/dev/urandom\",
\"/dev/ptmx\", \"/dev/kvm\", \"/dev/kqemu\",
\"/dev/rtc\", \"/dev/hpet\",\"/dev/net/tun\"
]",
	ensure=>present,
}


->

exec
{
	'net-destroy':
	command => '/usr/bin/virsh net-destroy default'
	
}
->
exec
{
	'net-undefine':
	command => '/usr/bin/virsh net-undefine default'
	
}

->

file 
{ 
'/var/openstack/libvirt/libvirtd.conf':
ensure => present,
source => '/etc/libvirt/libvirtd.conf',
}
->
editfile::config
{
	'listen_tls' :
	path => '/etc/libvirt/libvirtd.conf',
	entry => 'listen_tls',
	ensure => '0'	
}
->
editfile::config
{
	'listen_tcp' :
	path => '/etc/libvirt/libvirtd.conf',
	entry => 'listen_tcp',
	ensure => '1'	
}
->
editfile::config
{
	'auth_tcp' :
	path => '/etc/libvirt/libvirtd.conf',
	entry => 'auth_tcp',
	ensure => "\"none\""	
}
->
file
{   
	"/var/openstack/init":
	ensure => "directory",
}
->
file 
{ 
'/var/openstack/init/libvirt-bin.conf':
ensure => present,
source => '/etc/init/libvirt-bin.conf',
}
->
editfile::config
{
	'libvirtd_opts' :
	path => '/etc/init/libvirt-bin.conf',
	entry => 'env libvirtd_opts',
	ensure => "\"-d -l\""	
}
->
file
{   
	"/var/openstack/default":
	ensure => "directory",
}
->
file 
{ 
'/var/openstack/default/libvirt-bin':
ensure => present,
source => '/etc/default/libvirt-bin',
}
->
editfile::config
{
	'libvirtd-bin' :
	path => '/etc/default/libvirt-bin',
	entry => 'libvirtd_opts',
	ensure => "\"-d -l\""	
}

