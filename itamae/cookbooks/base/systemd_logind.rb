service 'systemd-logind' do
  action :nothing
end

template '/etc/systemd/logind.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :restart, 'service[systemd-logind]'
end
