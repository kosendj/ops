template '/etc/sysctl.d/50-kosendj-ipv4-forward.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :run, 'execute[sysctl --system]'
end
