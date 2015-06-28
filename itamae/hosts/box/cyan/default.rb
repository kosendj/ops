include_cookbook 'base'
include_cookbook 'nginx'

include_cookbook 'mysql-client'
include_cookbook 'mysql-server'

include_cookbook 'redis-client'
include_cookbook 'redis-server'

###

directory '/home/dj/app' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

###

execute 'git clone https://github.com/kosendj/gj /home/dj/app/gj' do
  user 'dj'
  not_if 'test -d  /home/dj/app/gj'
end

###

execute 'git clone https://github.com/kosendj/gjcase /home/dj/app/gjcase' do
  user 'dj'
  not_if 'test -d  /home/dj/app/gjcase'
end

###
#
remote_file '/etc/systemd/system/gjcase.service' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

execute 'touch /etc/gjcase.env' do
  not_if 'test -e /etc/gjcase.env'
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

remote_file '/etc/nginx/sites-enabled/gjcase' do
  owner 'root'
  group 'root'
  mode  '0644'
end

