include_cookbook 'base'
include_cookbook 'iptables-persistent'
include_cookbook 'nginx'
include_cookbook 'dnsmasq'

remote_file '/etc/dnsmasq.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
end

remote_file '/etc/iptables/rules.v4' do
  owner 'root'
  group 'root'
  mode  '0644'
end

remote_file '/etc/nginx/sites-enabled/storage' do
  owner 'root'
  group 'root'
  mode  '0644'
end

directory '/home/dj/app' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

include_cookbook 'camo'
