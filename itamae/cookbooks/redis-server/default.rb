package 'redis-server' do
end

service "redis-server" do
  action [:enable, :start]
end
