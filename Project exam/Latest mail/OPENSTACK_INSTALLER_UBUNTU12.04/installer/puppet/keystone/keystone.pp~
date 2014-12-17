#modules required : keystone,mysqlexec (change service-id to service_id and another warning)

import '/var/installer/ref.pp'
import '/var/installer/ports.pp'

$token=$admin_token
$endpoint="http://$host_ip:$auth_port/v2.0"


mysqlexec::db
{	
	'creating database':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbname=>$keystone_dbname,
	ensure=>present,
}
->
mysqlexec
{
	'granting access':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	mysqlcommand=>"GRANT ALL ON $keystone_dbname.* TO \"$keystone_dbuser\"@\"%\" IDENTIFIED BY \"$keystone_dbpass\""
}
->
mysqlexec::user
{	
	'granting access localhost':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbuser=>$keystone_dbuser,
	dbpassword=>$keystone_dbpass,
	privileges =>[ALL],
	dbname =>$keystone_dbname,
	ensure=>present,
}
->
package 
{ 
	'keystone' :
	ensure => installed,
}
->
package 
{ 
	'python-keystone' :
	ensure => installed,
}
->
package 
{ 
	'python-keystoneclient' :
	ensure => installed,
}
->
file
{ 
	'/var/lib/keystone/keystone.db' :
	ensure => absent,
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
	"/var/openstack/keystone":
	ensure => "directory",
}
->
file 
{ 
'/var/openstack/keystone/keystone.conf':
ensure => present,
source => '/etc/keystone/keystone.conf',
}
->
keystone_config
{
	'DEFAULT/admin_token':
	ensure=>present,
	value=>$admin_token
}
->
keystone_config
{
	'sql/connection':
	ensure=>present,
	value=>"mysql://$keystone_dbuser:$keystone_dbpass@$host_ip/$keystone_dbname",
}
->
exec 
{ 
	'restart':
	command=>'/usr/sbin/service keystone restart',
}
->
exec 
{ 
	'database sync':
	command=>'/usr/bin/keystone-manage db_sync',
}
->
file 
{ 
   '/etc/environment':
   content => inline_template("SERVICE_TOKEN=${token}\nSERVICE_ENDPOINT=${endpoint} ")
}
->
keystone_tenant 
{ $default_tenant:
  description=>'default tenant',
  ensure  => present,
  enabled => 'True',
}
->
keystone_user
{ 
  $default_user:
  tenant => $default_tenant,
  password => $default_password,
  ensure  => present,
  enabled => 'True',
}
->
keystone_role 
{ 'admin':
  ensure => present,
}
->
keystone_tenant 
{ $service_tenant:
  description=>'service tenant',
  ensure  => present,
  enabled => 'True',
}
->
keystone_user
{ 
  $glance_user:
  tenant => $service_tenant,
  password => $service_pass,
  ensure  => present,
  enabled => 'True',
}
->
keystone_user
{ 
  $nova_user:
  tenant => $service_tenant,
  password => $service_pass,
  ensure  => present,
  enabled => 'True',
}
->
keystone_user
{ 
  $quantum_user:
  tenant => $service_tenant,
  password => $service_pass,
  ensure  => present,
  enabled => 'True',
}
->
keystone_user
{ 
  $cinder_user:
  tenant => $service_tenant,
  password => $service_pass,
  ensure  => present,
  enabled => 'True',
}
->
keystone_service
{ 
  'keystone':
  type => 'identity',
  description => 'identity service',
  ensure  => present,
}
->
keystone_endpoint
{ 
  "$region_name/keystone":
  public_url => "http://$ext_host_ip:$keystone_port/v2.0",
  internal_url => "http://$host_ip:$keystone_port/v2.0",
  admin_url => "http://$host_ip:$auth_port/v2.0",
  ensure  => present,
}
->
keystone_service
{ 
  'glance':
  type => 'image',
  description => 'image service',
  ensure  => present,
}
->
keystone_endpoint
{ 
  "$region_name/glance":
  public_url => "http://$ext_host_ip:$glance_port/v2",
  internal_url => "http://$host_ip:$glance_port/v2",
  admin_url => "http://$host_ip:$glance_port/v2",
  ensure  => present,
}
->
keystone_service
{ 
  'volume':
  type => 'volume',
  description => 'volume service',
  ensure  => present,
}
->
keystone_endpoint
{ 
  "$region_name/volume":
  public_url => "http://$ext_host_ip:$volume_port/v1/%(tenant_id)s",
  internal_url => "http://$host_ip:$volume_port/v1/%(tenant_id)s",
  admin_url => "http://$host_ip:$volume_port/v1/%(tenant_id)s",
  ensure  => present,
}
->
keystone_service
{ 
  'quantum':
  type => 'network',
  description => 'object network service',
  ensure  => present,
}
->
keystone_endpoint
{ 
  "$region_name/quantum":
  public_url => "http://$ext_host_ip:$quantum_port/",
  internal_url => "http://$host_ip:$quantum_port/",
  admin_url => "http://$host_ip:$quantum_port/",
  ensure  => present,
}
->
keystone_service
{ 
  'nova':
  type => 'compute',
  description => 'compute service',
  ensure  => present,
}
->
keystone_endpoint
{ 
  "$region_name/nova":
  public_url => "http://$ext_host_ip:$nova_port/v2/%(tenant_id)s",
  internal_url => "http://$host_ip:$nova_port/v2/%(tenant_id)s",
  admin_url => "http://$host_ip:$nova_port/v2/%(tenant_id)s",
  ensure  => present,
}
->
keystone_user_role 
{ "$default_user@$default_tenant":				#user@tenant
  roles => 'admin',						#role
  ensure => present,
}
->
keystone_user_role 
{ 
  "$glance_user@$service_tenant":
  roles => 'admin',
  ensure => present,
}
->
keystone_user_role 
{ 
  "$nova_user@$service_tenant":
  roles => 'admin',
  ensure => present,
}
->
keystone_user_role 
{ 
  "$cinder_user@$service_tenant":
  roles => 'admin',
  ensure => present,
}
->
keystone_user_role 
{ 
  "$quantum_user@$service_tenant":
  roles => 'admin',
  ensure => present,
}

