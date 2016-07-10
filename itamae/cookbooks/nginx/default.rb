apt_key "C300EE8C" do
end

file "/etc/apt/sources.list.d/nginx.list" do
  content <<-EOF
deb http://ppa.launchpad.net/nginx/development/ubuntu #{node[:release]} main
deb-src http://ppa.launchpad.net/nginx/development/ubuntu #{node[:release]} main
  EOF

  owner 'root'
  group 'root'
  mode  '0644'

  notifies :run, "execute[apt-get update]", :immediately
end

directory '/tmp/nginx-tmp' do
  owner 'www-data'
  group 'www-data'
  mode  '0755'
end

remote_file '/etc/tmpfiles.d/djbu-nginx.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
end

directory '/var/lib/nginx-cache' do
  owner 'www-data'
  group 'www-data'
  mode  '0755'
end

package 'nginx-common' do
  action :install
end

package 'nginx-full' do
  action :install
end

package 'nginx' do
  action :install
end

directory "/etc/nginx/conf.d" do
  owner 'root'
  group 'root'
  mode  '0755'
end

directory "/etc/nginx/utils" do
  owner 'root'
  group 'root'
  mode  '0755'
end

template "/etc/nginx/conf.d/cidr.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :reload, 'service[nginx]'
end

template "/etc/nginx/utils/djbu_request_proto.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :reload, 'service[nginx]'
end

template "/etc/nginx/utils/force_https.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :reload, 'service[nginx]'
end

template "/etc/nginx/nginx.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :reload, 'service[nginx]'
end

template '/etc/nginx/sites-enabled/default' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :reload, 'service[nginx]'
end

service "nginx" do
  action [:enable, :start]
end
