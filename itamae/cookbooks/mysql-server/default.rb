package 'mysql-server-5.6' do
end

service 'mysql' do
  action [:enable, :start]
end
