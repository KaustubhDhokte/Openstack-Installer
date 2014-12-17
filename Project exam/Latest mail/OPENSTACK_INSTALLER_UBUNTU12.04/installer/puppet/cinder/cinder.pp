#modules needed : cinder,lvm
#use losetup -d to unmount volume

import '/var/installer/ref.pp'
import '/var/installer/ports.pp'

package 
{ 
	'cinder-api' :
	ensure => installed,
}
->
package 
{ 
	'cinder-scheduler' :
	ensure => installed,
}
->
package 
{ 
	'cinder-volume' :
	ensure => installed,
}
->
package 
{ 
	'iscsitarget' :
	ensure => installed,
}
->
package 
{ 
	'open-iscsi' :
	ensure => installed,
}
->
package 
{ 
	'iscsitarget-dkms' :
	ensure => installed,
}
->

package 
{ 
	'python-cinderclient' :
	ensure => installed,
}

->
exec
{
	'enabling_ip_forward':
	command=>"/bin/sed -i 's/false/true/g' /etc/default/iscsitarget"
}
->
exec 
{ 
	'starting iscsitarget':
	command=>'/usr/sbin/service iscsitarget start',
}
->
exec 
{ 
	'starting open-iscsi':
	command=>'/usr/sbin/service open-iscsi start',
}
->
mysqlexec::db
{	
	'creating database':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbname=>$cinder_dbname,
	ensure=>present,
}
->
mysqlexec
{
	'granting access':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	mysqlcommand=>"GRANT ALL ON $cinder_dbname.* TO \"$cinder_dbuser\"@\"%\" IDENTIFIED BY \"$cinder_dbpass\""
}
->
mysqlexec::user
{	
	'granting access localhost':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	privileges =>[ALL],
	dbuser=>$cinder_dbuser,
	dbpassword=>$cinder_dbpass,
	dbname =>$cinder_dbname,
	ensure=>present,
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
	"/var/openstack/cinder":
	ensure => "directory",
}
->
file 
{ 
'/var/openstack/cinder/api-paste.ini':
ensure => present,
source => '/etc/cinder/api-paste.ini',
}
->
cinder_api_paste_ini
{
	'filter:authtoken/paste.filter_factory':
	ensure=>present,	
	value=>'keystone.middleware.auth_token:filter_factory',
}
->
cinder_api_paste_ini
{
	'filter:authtoken/service_protocol':
	ensure=>present,	
	value=>'http',
}
->
cinder_api_paste_ini
{
	'filter:authtoken/service_host':
	ensure=>present,	
	value=>$ext_host_ip,
}
->
cinder_api_paste_ini
{
	'filter:authtoken/service_port':
	ensure=>present,	
	value=>$keystone_port,
}
->
cinder_api_paste_ini
{
	'filter:authtoken/auth_host':
	ensure=>present,	
	value=>$host_ip,
}
->
cinder_api_paste_ini
{
	'filter:authtoken/auth_port':
	ensure=>present,	
	value=>$auth_port,
}
->
cinder_api_paste_ini
{
	'filter:authtoken/auth_protocol':
	ensure=>present,	
	value=>'http',
}
->
cinder_api_paste_ini
{
	'filter:authtoken/admin_tenant_name':
	ensure=>present,	
	value=>$service_tenant,
}
->
cinder_api_paste_ini
{
	'filter:authtoken/admin_user':
	ensure=>present,	
	value=>$cinder_user,
}
->
cinder_api_paste_ini
{
	'filter:authtoken/admin_password':
	ensure=>present,	
	value=>$service_pass,
}
->
file 
{ 
'/var/openstack/cinder/cinder.conf':
ensure => present,
source => '/etc/cinder/cinder.conf',
}
->
cinder_config
{
	'DEFAULT/rootwrap_config':
	ensure=>present,	
	value=>'/etc/cinder/rootwrap.conf',
}
->
cinder_config
{
	'DEFAULT/sql_connection':
	ensure=>present,	
	value=>"mysql://$cinder_dbuser:$cinder_dbpass@$host_ip/$cinder_dbname",
}
->
cinder_config
{
	'DEFAULT/api_paste_config':
	ensure=>present,	
	value=>'/etc/cinder/api-paste.ini',
}
->
cinder_config
{
	'DEFAULT/iscsi_helper':
	ensure=>present,	
	value=>'ietadm',
}
->

cinder_config
{
	'DEFAULT/volume_name_template':
	ensure=>present,	
	value=>'volume-%s',
}
->
cinder_config
{
	'DEFAULT/volume_group':
	ensure=>present,	
	value=>'cinder-volumes',
}
->
cinder_config
{
	'DEFAULT/verbose':
	ensure=>present,	
	value=>True,
}
->
cinder_config
{
	'DEFAULT/auth_strategy':
	ensure=>present,	
	value=>'keystone',
}
->
cinder_config
{
	'DEFAULT/osapi_volume_listen_port':
	ensure=>absent,	
}
->
exec 
{ 
	'database sync':
	command=>'/usr/bin/cinder-manage db sync',
}
->
exec 
{ 
	'creating test loopfile':
	command=>'/bin/dd if=/dev/zero of=/var/openstack/cinder/cinder-volumes bs=1 count=0 seek=4G',
}

->
exec 
{ 
	'mounting':
	command=>'/sbin/losetup /dev/loop2 /var/openstack/cinder/cinder-volumes',
}
->
physical_volume
{
	'/dev/loop2':
	ensure=>present,
}
->
volume_group
{
	'cinder-volumes':
	ensure=>present,
	physical_volumes=>'/dev/loop2'	
}
->
file_line 
{ 
	'care reboot1':
	path => '/etc/rc.local',
	line => 'exit 0',
	ensure=>absent,
}
->
file_line 
{ 
	'care reboot2':
	path => '/etc/rc.local',
	line => 'losetup /dev/loop2 /var/openstack/cinder/cinder-volumes',
	ensure=>absent,
}
->
file_line 
{ 
	'care reboot3':
	path => '/etc/rc.local',
	line => 'losetup /dev/loop2 /var/openstack/cinder/cinder-volumes
exit 0',
	ensure=>present,
}
->
exec 
{ 
	'restart cinder-volume':
	command=>'/usr/sbin/service cinder-volume restart',
}
->
exec 
{ 
	'restart cinder-api':
	command=>'/usr/sbin/service cinder-api restart',
}
->
exec 
{ 
	'restart cinder-scheduler':
	command=>'/usr/sbin/service cinder-scheduler restart',
}



