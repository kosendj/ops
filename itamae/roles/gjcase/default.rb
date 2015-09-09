include_cookbook 'nginx'

include_cookbook 'mysql-client'
include_cookbook 'redis-client'

include_cookbook 'app_directory'

execute 'git clone https://github.com/kosendj/gjcase /home/dj/app/gjcase' do
  user 'dj'
  not_if 'test -d /home/dj/app/gjcase'
end

remote_file '/etc/systemd/system/gjcase.service' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

remote_file '/etc/nginx/sites-enabled/gjcase' do
  owner 'root'
  group 'root'
  mode  '0644'
end

service 'gjcase' do
  action %i(enable start)
end
