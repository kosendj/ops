node.reverse_merge!(
  dns_cache: {
  }
)

include_role 'internal-dns' unless node[:dns_cache][:upstream]

include_cookbook 'unbound'

template '/etc/unbound/unbound.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
end

service 'unbound' do
  action %i(enable start)
end
