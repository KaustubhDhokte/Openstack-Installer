import '/var/installer/ref.pp'
import '/var/installer/ports.pp'

file 
{ 
   '/etc/environment':
   content =>"",
}
->
exec
{
	'user-list':
	environment=>["OS_USERNAME=$default_user" , "OS_PASSWORD=$default_password" ,"OS_AUTH_URL=http://$host_ip:$keystone_port/v2.0","OS_TENANT_NAME=$default_tenant","OS_REGION_NAME=$region_name"],
	logoutput=>true,
	command=>'/usr/bin/keystone user-list',
}



