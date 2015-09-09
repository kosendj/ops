include_cookbook 'mysql-server'

node.validate! do
  {
    mysqld: {
      server_id: string,
    },
  }
end

template '/etc/mysql/my.cnf' do
  owner 'root'
  group 'root'
  mode  '0644'
end

service 'mysql' do
  action [:enable, :start]
end
