include_cookbook 'redis-server'

template "/etc/redis/redis.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
end

service "redis-server" do
  action [:enable, :start]
end
