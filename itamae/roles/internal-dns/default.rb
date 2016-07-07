include_cookbook 'nsd'

template '/etc/nsd/nsd.conf' do
  owner 'root'
  group 'nsd'
  mode  '0640'
end

template '/var/lib/nsd/c.kosendj-bu.in.forward.zone' do
  owner 'root'
  group 'nsd'
  mode  '0640'
end


template '/var/lib/nsd/c.kosendj-bu.in.reverse.zone' do
  owner 'root'
  group 'nsd'
  mode  '0640'
end

service 'nsd' do
  action [:enable, :start]
end
