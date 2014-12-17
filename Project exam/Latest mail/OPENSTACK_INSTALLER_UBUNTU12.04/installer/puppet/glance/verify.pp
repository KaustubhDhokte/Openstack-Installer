import '/var/installer/ref.pp'
import '/var/installer/ports.pp'

exec
{
	'image-create':
	environment=>["OS_USERNAME=$default_user" , "OS_PASSWORD=$default_password" ,"OS_AUTH_URL=http://$host_ip:$keystone_port/v2.0","OS_TENANT_NAME=$default_tenant","OS_REGION_NAME=$region_name"],
	logoutput=>true,
	command=>'/usr/bin/glance image-create --name myFirstImage --is-public true --container-format bare --disk-format qcow2 --location https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img',
}
->
exec
{
	'image-list':
	environment=>["OS_USERNAME=$default_user" , "OS_PASSWORD=$default_password" ,"OS_AUTH_URL=http://$host_ip:$keystone_port/v2.0","OS_TENANT_NAME=$default_tenant","OS_REGION_NAME=$region_name"],
	logoutput=>true,
	command=>'/usr/bin/glance image-list'
}


