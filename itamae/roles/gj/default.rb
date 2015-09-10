include_cookbook 'nginx'

include_cookbook 'redis-client'

include_cookbook 'app_directory'

###

directory '/home/dj/app/gj' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

directory '/home/dj/app/gj/shared' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

###

execute 'git clone https://github.com/kosendj/gj /home/dj/app/gj/git' do
  user 'dj'
  not_if 'test -d /home/dj/app/gj/git'
end

link '/home/dj/app/gj/current' do
  to 'git'
end

###

template '/etc/gj.env' do
  owner 'root'
  group 'dj'
  mode  '0640'
end

remote_file '/etc/systemd/system/gj.service' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

###

remote_file '/etc/nginx/sites-enabled/gj' do
  owner 'root'
  group 'root'
  mode  '0644'
end

###

service 'gj' do
  action %i(enable start)
end
