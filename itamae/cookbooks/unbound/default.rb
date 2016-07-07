package "unbound" do
end

remote_file "/etc/unbound/root-hints.named.cache" do
  owner 'root'
  group 'root'
  mode  '0444'
end

execute 'unbound-anchor -v; unbound-anchor -v' do
  not_if 'test -e /etc/unbound/root.key'
end

directory '/etc/unbound' do
  owner 'unbound'
  group 'unbound'
  mode  '0755'
end

file '/etc/unbound/root.key' do
  owner 'unbound'
  group 'unbound'
  mode  '0644'
end

execute 'unbound-control-setup' do
  user 'root'
  command '/usr/sbin/unbound-control-setup -d /etc/unbound && chgrp unbound /etc/unbound/*.pem /etc/unbound/*.key && chmod 640 /etc/unbound/*.pem /etc/unbound/*.key'
  not_if 'test -f /etc/unbound/unbound_control.key -a -f /etc/unbound/unbound_control.pem -a -f /etc/unbound/unbound_server.key -a -f /etc/unbound/unbound_server.pem'
end
