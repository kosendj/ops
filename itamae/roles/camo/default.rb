include_cookbook 'app_directory'
include_cookbook 'nginx'

execute 'git clone https://github.com/atmos/camo /home/dj/app/camo' do
  user 'dj'
  not_if 'test -d  /home/dj/app/camo'
end

remote_file '/etc/nginx/sites-enabled/camo' do
  owner 'root'
  group 'root'
  mode  '0644'
end

remote_file '/etc/systemd/system/camo.service' do
  owner 'root'
  group 'root'
  mode  '0644'

  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

execute 'create camo.env' do
  command "echo 'CAMO_KEY=deadbeef' > /etc/camo.env"
  not_if 'test -e /etc/camo.env'
end

service "camo" do
  action %i(start enable)
end
