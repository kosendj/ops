node.reverse_merge!(
  mysqld: {
    server_id: '1',
  },
  gjcase: {
    private_mode: true,
  },
)

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

include_role 'mysql-server'
include_role 'redis-server'

include_role 'nginx-omniauth-adapter'
include_role 'gjcase'
