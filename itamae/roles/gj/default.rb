include_cookbook 'nginx'

include_cookbook 'redis-client'
include_cookbook 'redis-server'

include_cookbook 'app_directory'

execute 'git clone https://github.com/kosendj/gj /home/dj/app/gj' do
  user 'dj'
  not_if 'test -d /home/dj/app/gj'
end

execute 'touch /etc/gj.env' do
  not_if 'test -e /etc/gj.env'
end

remote_file '/etc/systemd/system/gj.service' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

remote_file '/etc/nginx/sites-enabled/gj' do
  owner 'root'
  group 'root'
  mode  '0644'
end
