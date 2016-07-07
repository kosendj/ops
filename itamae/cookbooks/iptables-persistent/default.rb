node.reverse_merge!(
  iptables_persistent: {
  },
)

package "netfilter-persistent" do
end

package "iptables-persistent" do
end


directory '/etc/iptables' do
  owner 'root'
  group 'root'
  mode  '0755'
end
