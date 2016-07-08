include_cookbook 'nginx'
if node[:gjcase][:private_mode]
  include_cookbook 'nginx::nginx_omniauth_adapter'
end

include_cookbook 'configurator'

include_cookbook 'mysql-client'
include_cookbook 'redis-client'

include_cookbook 'app_directory'

include_cookbook 'sqlite3'

###

directory '/home/dj/app/gjcase' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

directory '/home/dj/app/gjcase/shared' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

directory '/home/dj/app/gjcase/shared/tmp' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

directory '/home/dj/app/gjcase/shared/bundle' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

directory '/home/dj/app/gjcase/shared/assets' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

template '/home/dj/app/gjcase/shared/env.sh' do
  owner 'dj'
  group 'dj'
  mode  '0750'
end

###

%w(
  gjcase-import-tumblelog
  gjcase-import-tag
  gjcase-import-url
).each do |cmd|
  remote_file "/usr/bin/#{cmd}" do
    owner 'root'
    group 'root'
    mode  '0755'
  end
end

###

execute 'git clone https://github.com/kosendj/gjcase /home/dj/app/gjcase/git' do
  user 'dj'
  not_if 'test -d /home/dj/app/gjcase/git'
end

link '/home/dj/app/gjcase/current' do
  to 'git'
end


###

remote_file '/etc/systemd/system/gjcase.service' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

template '/etc/nginx/sites-enabled/gjcase' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :reload, 'service[nginx]'
end

###

remote_file '/etc/systemd/system/gjcase-sidekiq.service' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

###

service 'gjcase' do
  action %i(enable start)
end
