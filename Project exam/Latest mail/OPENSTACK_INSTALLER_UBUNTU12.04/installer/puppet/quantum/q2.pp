
import '/var/installer/ref.pp'
import '/var/installer/ports.pp'

mysqlexec::db
{	
	'creating database':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbname=>$quantum_dbname,
	ensure=>present,
}
->
mysqlexec
{
	'granting access':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	mysqlcommand=>"GRANT ALL ON $quantum_dbname.* TO \"$quantum_dbuser\"@\"%\" IDENTIFIED BY \"$quantum_dbpass\""
}
->
mysqlexec::user
{	
	'granting access localhost':
	host=>localhost,
	username=>root,
	password=>$mysql_root_password,
	dbuser=>$quantum_dbuser,
	dbpassword=>$quantum_dbpass,
	privileges =>[ALL],
	dbname =>$quantum_dbname,
	ensure=>present,
}
->

#taking backup and updating /etc/quantum/api-paste.ini

file
{
	"/var/openstack":
	ensure=>"directory",
}
->
file
{
	"/var/openstack/quantum":
	ensure=>"directory",
}
->
file 
{ 
'/var/openstack/quantum/api-paste.ini':
ensure => present,
source => '/etc/quantum/api-paste.ini',
}
->
quantum_api_config
{
	'filter:authtoken/paste.filter_factory':
	ensure=>present,
	value=>'keystoneclient.middleware.auth_token:filter_factory'
}
->
quantum_api_config
{
	'filter:authtoken/auth_host':
	ensure=>present,
	value=>$host_ip
}
->
quantum_api_config
{
	'filter:authtoken/auth_port':
	ensure=>present,
	value=>$auth_port
}
->
quantum_api_config
{
	'filter:authtoken/auth_protocol':
	ensure=>present,
	value=>'http'
}
->
quantum_api_config
{
	'filter:authtoken/admin_tenant_name':
	ensure=>present,
	value=>$service_tenant	
}
->
quantum_api_config
{
	'filter:authtoken/admin_user':
	ensure=>present,
	value=>$quantum_user
}
->
quantum_api_config
{
	'filter:authtoken/admin_password':
	ensure=>present,
	value=>$service_pass	
}
->

#taking backup and updating /etc/quantum/plugins/openvswitch/ovs_quantum_plugin.ini
file
{
	"/var/openstack/quantum/plugins":
	ensure=>"directory",
}
->
file
{
	"/var/openstack/quantum/plugins/openvswitch":
	ensure=>"directory",
}
->
file 
{ 
'/var/openstack/quantum/plugins/openvswitch/ovs_quantum_plugin.ini':
ensure => present,
source => '/etc/quantum/plugins/openvswitch/ovs_quantum_plugin.ini',
}

->
quantum_plugin_ovs
{
	'DATABASE/sql_connection':
	ensure=>present,
	value=>"mysql://$quantum_dbuser:$quantum_dbpass@$host_ip/$quantum_dbname"
}
->
quantum_plugin_ovs
{
	'OVS/tenant_network_type':
	ensure=>present,
	value=>'gre'
}
->
quantum_plugin_ovs
{
	'OVS/tunnel_id_ranges':
	ensure=>present,
	value=>'1:1000'
}
->
quantum_plugin_ovs
{
	'OVS/integration_bridge':
	ensure=>present,
	value=>'br-int'
}
->
quantum_plugin_ovs
{
	'OVS/tunnel_bridge':
	ensure=>present,
	value=>'br-tun'
}
->
quantum_plugin_ovs
{
	'OVS/local_ip':
	ensure=>present,
	value=>$host_ip
}
->
quantum_plugin_ovs
{
	'OVS/enable_tunneling':
	ensure=>present,
	value=>'True'
}
->
quantum_plugin_ovs
{
	'SECURITYGROUP/firewall_driver':
	ensure=>present,
	value=>'quantum.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver'
}
->



#taking backup and updating /etc/quantum/metadata_agent.ini


file 
{ 
'/var/openstack/quantum/metadata_agent.ini':
ensure => present,
source => '/etc/quantum/metadata_agent.ini',
}
->
quantum_metadata_agent_config
{
	'DEFAULT/auth_url':
	ensure=>present,
	value=>"http://$host_ip:$auth_port/v2.0"	
}
->
quantum_metadata_agent_config
{
	'DEFAULT/auth_region':
	ensure=>present,
	value=>$region_name	
}
->
quantum_metadata_agent_config
{
	'DEFAULT/admin_tenant_name':
	ensure=>present,
	value=>$service_tenant	
}
->
quantum_metadata_agent_config
{
	'DEFAULT/admin_user':
	ensure=>present,
	value=>$quantum_user	
}
->
quantum_metadata_agent_config
{
	'DEFAULT/admin_password':
	ensure=>present,
	value=>$service_pass	
}
->
quantum_metadata_agent_config
{
	'DEFAULT/nova_metadata_ip':
	ensure=>present,
	value=>'127.0.0.1'	
}
->
quantum_metadata_agent_config
{
	'DEFAULT/nova_metadata_port':
	ensure=>present,
	value=>'8775'	
}
->
quantum_metadata_agent_config
{
	'DEFAULT/metadata_proxy_shared_secret':
	ensure=>present,
	value=>'helloOpenstack'	
}
->


#taking backup and updating /etc/quantum/quantum.conf to above values

file 
{ 
'/var/openstack/quantum/quantum.conf':
ensure => present,
source => '/etc/quantum/quantum.conf',
}
->
quantum_config
{
	'keystone_authtoken/auth_host':
	ensure=>present,
	value=>$host_ip
}
->
quantum_config
{
	'keystone_authtoken/auth_port':
	ensure=>present,
	value=>$auth_port
}
->
quantum_config
{
	'keystone_authtoken/auth_protocol':
	ensure=>present,
	value=>'http'
}
->
quantum_config
{
	'keystone_authtoken/admin_tenant_name':
	ensure=>present,
	value=>$service_tenant
}
->
quantum_config
{
	'keystone_authtoken/admin_user':
	ensure=>present,
	value=> $quantum_user
}
->
quantum_config
{
	'keystone_authtoken/admin_password':
	ensure=>present,
	value=>$service_pass
}
->
quantum_config
{
	'keystone_authtoken/signing_dir':
	ensure=>present,
	value=>'/var/lib/quantum/keystone-signing'
}
->


#restarting above services
exec 
{ 
	'restart_dhcpagent':
	command=>'/usr/sbin/service quantum-dhcp-agent restart',
}
->
exec 
{ 
	'restart_l3':
	command=>'/usr/sbin/service quantum-l3-agent restart',
}
->
exec 
{ 
	'restart_metadata_agent':
	command=>'/usr/sbin/service quantum-metadata-agent restart',
}
->
exec 
{ 
	'restart_ovs_agent':
	command=>'/usr/sbin/service quantum-plugin-openvswitch-agent restart',
}
->
exec 
{ 
	'restart_qserver':
	command=>'/usr/sbin/service quantum-server restart',
}
->
exec 
{ 
	'restart_dnsmasq':
	command=>'/usr/sbin/service dnsmasq restart',
}


