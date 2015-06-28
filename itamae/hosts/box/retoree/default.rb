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

include_role 'gjcase_storage'
include_role 'camo'
