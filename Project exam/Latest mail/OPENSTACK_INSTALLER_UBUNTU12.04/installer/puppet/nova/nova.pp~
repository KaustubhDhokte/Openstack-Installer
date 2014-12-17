#modules needed : nova

import '/var/installer/ref.pp'
import '/var/installer/ports.pp'

package 
{ 
	'nova-api' :
	ensure => installed,
}
->
package 
{ 
	'nova-cert' :
	ensure => installed,
}
->
package 
{ 
	'novnc' :
	ensure => installed,
}
->
package 
{ 
	'nova-consoleauth' :
	ensure => installed,
}
->
package 
{ 
	'nova-scheduler' :
	ensure => installed,
}
->
package 
{ 
	'nova-novncproxy' : 
	ensure => installed,
}
->
package 
{ 
	'nova-doc' :
	ensure => installed,
}
->
package 
{ 
	'nova-conductor' :
	ensure => installed,
}
->
package 
{ 
	'nova-compute-kvm' : 
	ensure => installed,
}
->
mysqlexec::db
{	
	'creating database':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbname=>$nova_dbname,
	ensure=>present,
}
->
mysqlexec
{
	'granting access':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	mysqlcommand=>"GRANT ALL ON $nova_dbname.* TO \"$nova_dbuser\"@\"%\" IDENTIFIED BY \"$nova_dbpass\""
}
->
mysqlexec::user
{	
	'granting access localhost':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbuser=>$nova_dbuser,
	dbpassword=>$nova_dbpass,
	privileges =>[ALL],
	dbname =>$nova_dbname,
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
	"/var/openstack/nova":
	ensure => "directory",
}
->
file 
{ 
'/var/openstack/nova/api-paste.ini':
ensure => present,
source => '/etc/nova/api-paste.ini',
}
->
nova_paste_api_ini
{
	'filter:authtoken/paste.filter_factory':
	ensure=>present,	
	value=>'keystone.middleware.auth_token:filter_factory',
}
->
nova_paste_api_ini
{
	'filter:authtoken/auth_host':
	ensure=>present,	
	value=>$host_ip,
}
->
nova_paste_api_ini
{
	'filter:authtoken/auth_port':
	ensure=>present,	
	value=>$auth_port,
}
->
nova_paste_api_ini
{
	'filter:authtoken/auth_protocol':
	ensure=>present,	
	value=>'http',
}
->
nova_paste_api_ini
{
	'filter:authtoken/admin_tenant_name':
	ensure=>present,	
	value=>$service_tenant,
}
->
nova_paste_api_ini
{
	'filter:authtoken/admin_user':
	ensure=>present,	
	value=>$nova_user,
}
->
nova_paste_api_ini
{
	'filter:authtoken/admin_password':
	ensure=>present,	
	value=>$service_pass,
}
->
nova_paste_api_ini
{
	'filter:authtoken/signing_dirname':
	ensure=>present,	
	value=>'/tmp/keystone-signing-nova',
}
->
nova_paste_api_ini
{
	'filter:authtoken/auth_version':
	ensure=>present,	
	value=>'v2.0',
}
->
file 
{ 
'/var/openstack/nova/nova.conf':
ensure => present,
source => '/etc/nova/nova.conf',
}
->
nova_config
{
	'DEFAULT/dhcpbridge_flagfile' :
	ensure=>absent,
}
->
nova_config
{
	'DEFAULT/dhcpbridge' :
	ensure=>absent,
}
->
nova_config
{
	'DEFAULT/force_dhcp_release' :
	ensure=>absent,
}
->
nova_config
{
	'DEFAULT/iscsi_helper' :
	ensure=>absent,
}
->
nova_config
{
	'DEFAULT/libvirt_use_virtio_for_bridges' :
	ensure=>absent,
}
->
nova_config
{
	'DEFAULT/connection_type' :
	ensure=>absent,
}
->
nova_config
{
	'DEFAULT/ec2_private_dns_show_ip' :
	ensure=>absent,
}
->
nova_config
{
	'DEFAULT/volumes_path' :
	ensure=>absent,
}
->
nova_config
{
	'DEFAULT/enabled_apis' :
	ensure=>absent,
}
->
nova_config
{
	'DEFAULT/logdir' :
	ensure=>present,
	value=>'/var/log/nova'
}
->
nova_config
{
	'DEFAULT/state_path' :
	ensure=>present,
	value=>'/var/lib/nova'
}
->
nova_config
{
	'DEFAULT/lock_path' :
	ensure=>present,
	value=>'/run/lock/nova'
}
->
nova_config
{
	'DEFAULT/api_paste_config' :
	ensure=>present,
	value=>'/etc/nova/api-paste.ini'
}
->
nova_config
{
	'DEFAULT/compute_scheduler_driver' :
	ensure=>present,
	value=>'nova.scheduler.simple.SimpleScheduler'
}
->
nova_config
{
	'DEFAULT/rabbit_host' :
	ensure=>present,
	value=>"$host_ip"
}
->
nova_config
{
	'DEFAULT/nova_url' :
	ensure=>present,
	value=>"http://$host_ip:$nova_port/v1.1/"
}
->
nova_config
{
	'DEFAULT/sql_connection' :
	ensure=>present,	
	value=>"mysql://$nova_dbuser:$nova_dbpass@$host_ip/$nova_dbname",
}
->
nova_config
{
	'DEFAULT/root_helper' :
	ensure=>present,
	value=>'sudo nova-rootwrap /etc/nova/rootwrap.conf'
}
->
nova_config
{
	'DEFAULT/use_deprecated_auth' :
	ensure=>present,
	value=>'false'
}
->
nova_config
{
	'DEFAULT/auth_strategy' :
	ensure=>present,
	value=>'keystone'
}
->
nova_config
{
	'DEFAULT/glance_api_servers' :
	ensure=>present,
	value=>"$host_ip:$glance_port"
}
->
nova_config
{
	'DEFAULT/image_service' :
	ensure=>present,
	value=>'nova.image.glance.GlanceImageService'
}
->
nova_config
{
	'DEFAULT/novnc_enabled' :
	ensure=>present,
	value=>'true'
}
->
nova_config
{
	'DEFAULT/novncproxy_base_url' :
	ensure=>present,
	value=>'http://127.0.0.1:6080/vnc_auto.html'
}
->
nova_config
{
	'DEFAULT/novncproxy_port' :
	ensure=>present,
	value=>'6080'
}
->
nova_config
{
	'DEFAULT/vncserver_proxyclient_address' :
	ensure=>present,
	value=>'127.0.0.1'
}
->
nova_config
{
	'DEFAULT/vncserver_listen' :
	ensure=>present,
	value=>'0.0.0.0'
}
->
nova_config
{
	'DEFAULT/network_api_class' :
	ensure=>present,
	value=>'nova.network.quantumv2.api.API'
}
->
nova_config
{
	'DEFAULT/quantum_url' :
	ensure=>present,
	value=>"http://$host_ip:$quantum port"
}
->
nova_config
{
	'DEFAULT/quantum_auth_strategy' :
	ensure=>present,
	value=>'keystone'
}
->
nova_config
{
	'DEFAULT/quantum_admin_tenant_name' :
	ensure=>present,
	value=>"$service_tenant"
}
->
nova_config
{
	'DEFAULT/quantum_admin_username' :
	ensure=>present,
	value=>"$quantum_user"
}
->
nova_config
{
	'DEFAULT/quantum_admin_password' :
	ensure=>present,
	value=>"$service_pass"
}
->
nova_config
{
	'DEFAULT/quantum_admin_auth_url' :
	ensure=>present,
	value=>"http://$host_ip:$auth_port/v2.0"
}
->
nova_config
{
	'DEFAULT/libvirt_vif_driver' :
	ensure=>present,
	value=>'nova.virt.libvirt.vif.LibvirtHybridOVSBridgeDriver'
}
->
nova_config
{
	'DEFAULT/linuxnet_interface_driver' :
	ensure=>present,
	value=>'nova.network.linux_net.LinuxOVSInterfaceDriver'
}
->
nova_config
{
	'DEFAULT/firewall_driver' :
	ensure=>present,
	value=>'nova.virt.firewall.NoopFirewallDriver'
}
->
nova_config
{
	'DEFAULT/security_group_api' :
	ensure=>present,
	value=>'quantum'
}
->
nova_config
{
	'DEFAULT/service_quantum_metadata_proxy' :
	ensure=>present,
	value=>'True'
}
->
nova_config
{
	'DEFAULT/quantum_metadata_proxy_shared_secret' :
	ensure=>present,
	value=>'helloOpenStack'
}
->
nova_config
{
	'DEFAULT/metadata_host' :
	ensure=>present,
	value=>'127.0.0.1'
}
->
nova_config
{
	'DEFAULT/metadata_listen' :
	ensure=>present,
	value=>'127.0.0.1'
}
->
nova_config
{
	'DEFAULT/metadata_listen_port' :
	ensure=>present,
	value=>'8775'
}
->
nova_config
{
	'DEFAULT/compute_driver' :
	ensure=>present,
	value=>'libvirt.LibvirtDriver'
}
->
nova_config
{
	'DEFAULT/volume_api_class' :
	ensure=>present,
	value=>'nova.volume.cinder.API'
}
->
nova_config
{
	'DEFAULT/osapi_volume_listen_port' :
	ensure=>present,
	value=>'5900'
}
->
nova_config
{
	'DEFAULT/verbose' :
	ensure=>present,
	value=>'true'
}
->
file 
{ 
'/var/openstack/nova/nova-compute.conf':
ensure => present,
source => '/etc/nova/nova-compute.conf',
}
->
exec
{
	'rm nova-compute.conf':
	command => '/bin/rm /etc/nova/nova-compute.conf'
}
->
file 
{ 
'/etc/nova/nova-compute.conf':
ensure => present,
source => '/var/installer/attach/nova/nova-compute.conf',
}
->
exec 
{ 
	'database sync':
	command=>'/usr/bin/nova-manage db sync',
}
->
exec 
{ 
	'restart1':
	command=>'/usr/sbin/service nova-api restart',
}
->
exec 
{ 
	'restart2':
	command=>'/usr/sbin/service nova-cert restart',
}
->
exec 
{ 
	'restart3':
	command=>'/usr/sbin/service nova-compute restart',
}
->
exec 
{ 
	'restart4':
	command=>'/usr/sbin/service nova-conductor restart',
}
->
exec 
{ 
	'restart5':
	command=>'/usr/sbin/service nova-consoleauth restart',
}
->
exec 
{ 
	'restart6':
	command=>'/usr/sbin/service nova-novncproxy restart',
}
->
exec 
{ 
	'restart7':
	command=>'/usr/sbin/service nova-scheduler restart',
}

