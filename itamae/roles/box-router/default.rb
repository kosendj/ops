include_cookbook 'dnsmasq'

remote_file '/etc/dnsmasq.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
end
