apt_key "C300EE8C" do
end

file "/etc/apt/sources.list.d/nginx.list" do
  content <<-EOF
deb http://ppa.launchpad.net/nginx/development/ubuntu vivid main 
deb-src http://ppa.launchpad.net/nginx/development/ubuntu vivid main 
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

template "/etc/nginx/nginx.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
end

service "nginx" do
  action [:enable, :start]
end
