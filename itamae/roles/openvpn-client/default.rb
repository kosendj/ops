include_cookbook 'openvpn'

file '/etc/openvpn/client.key' do
  content node[:openvpn][:key].concat(?\n)
  owner 'root'
  group 'root'
  mode  '0440'
end

file '/etc/openvpn/client.crt' do
  content node[:openvpn][:cert].chomp.concat(?\n)
  owner 'root'
  group 'root'
  mode  '0444'
end

template '/etc/openvpn/client.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
end

link '/etc/systemd/system/openvpn@client.conf' do
  to '/lib/systemd/system/openvpn@.service'
end

service 'openvpn@client' do
  action %i(enable start)
end

