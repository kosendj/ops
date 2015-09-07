include_cookbook 'iptables-persistent'
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

remote_file '/etc/sysctl.d/50-kosendj-router.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :run, 'execute[sysctl --system]'
end


