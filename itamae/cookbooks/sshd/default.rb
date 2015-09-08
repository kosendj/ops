node.reverse_merge!(
  sshd: {
    listen_port22: false,
  }
)

package 'openssh-server' do
end

template '/etc/ssh/sshd_config' do
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :restart, 'service[ssh]'
end

service 'ssh' do
  action [:enable, :start]
end
