package "nsd" do
end

execute 'nsd-control-setup' do
  user 'root'
  command '/usr/sbin/nsd-control-setup -d /etc/nsd && chgrp nsd /etc/nsd/*.pem /etc/nsd/*.key && chmod 640 /etc/nsd/*.pem /etc/nsd/*.key'
  not_if 'test -f /etc/nsd/nsd_control.key -a -f /etc/nsd/nsd_control.pem -a -f /etc/nsd/nsd_server.key -a -f /etc/nsd/nsd_server.pem'
end
