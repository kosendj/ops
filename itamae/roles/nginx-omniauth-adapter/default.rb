include_cookbook 'nginx'
include_cookbook 'nginx::nginx_omniauth_adapter'

include_cookbook 'app_directory'

###

directory '/home/dj/app/nginx_omniauth_adapter' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

directory '/home/dj/app/nginx_omniauth_adapter/shared' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

template '/home/dj/app/nginx_omniauth_adapter/shared/env.sh' do
  owner 'dj'
  group 'dj'
  mode  '0750'
end

###

execute 'git clone https://github.com/sorah/nginx_omniauth_adapter /home/dj/app/nginx_omniauth_adapter/git' do
  user 'dj'
  not_if 'test -d /home/dj/app/nginx_omniauth_adapter/git'
end

link '/home/dj/app/nginx_omniauth_adapter/current' do
  to 'git'
end

###

remote_file '/home/dj/app/nginx_omniauth_adapter/shared/unicorn.conf' do
  owner 'dj'
  group 'dj'
  mode '0644'
end

remote_file '/etc/systemd/system/nginx_omniauth_adapter.service' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

template '/etc/nginx/sites-enabled/nginx_omniauth_adapter' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :reload, 'service[nginx]'
end

###

service 'nginx_omniauth_adapter' do
  action %i(enable start)
end
