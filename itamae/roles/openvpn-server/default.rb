include_cookbook 'openvpn'
include_cookbook 'sysctl-ipv4-forward'

file '/etc/openvpn/server.key' do
  content node[:openvpn][:key].concat(?\n)
  owner 'root'
  group 'root'
  mode  '0440'
end

file '/etc/openvpn/server.crt' do
  content node[:openvpn][:cert].chomp.concat(?\n)
  owner 'root'
  group 'root'
  mode  '0444'
end

template '/etc/openvpn/server.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
end

directory '/etc/openvpn/server-ccd' do
  owner 'root'
  group 'root'
  mode  '0755'
end

template '/etc/openvpn/server-ccd/retoree' do
  owner 'root'
  group 'root'
  mode  '0644'
end

execute 'touch /etc/openvpn/dh1024.pem && chmod 440 /etc/openvpn/dh1024.pem && openssl dhparam -out /etc/openvpn/dh1024.pem 1024' do
  not_if 'test -e /etc/openvpn/dh1024.pem'
end

link '/etc/systemd/system/openvpn@server.conf' do
  to '/lib/systemd/system/openvpn@.service'
end

service 'openvpn@server' do
  action %i(enable start)
end
