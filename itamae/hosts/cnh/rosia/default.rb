node.reverse_merge!(
  mysqld: {
    server_id: '1',
  },
  gjcase: {
    private_mode: true,
    aws_access_key_id: node[:secrets][:'aws-gjcase_rosia-access_key_id'],
    aws_secret_access_key: node[:secrets][:'aws-gjcase_rosia-secret_access_key'],
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

include_role 'internal-dns'

include_role 'nginx-omniauth-adapter'
include_role 'gjcase'
include_role 'gj'
include_role 'camo'
