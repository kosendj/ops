include_recipe '../base/default.rb'

include_cookbook 'iptables-persistent'

remote_file '/etc/iptables/rules.v4' do
  owner 'root'
  group 'root'
  mode  '0644'
end

remote_file '/etc/iptables/rules.v6' do
  owner 'root'
  group 'root'
  mode  '0644'
end
