include_cookbook 'iptables-persistent'

node.reverse_merge!(
  iptables_persistent: {
  },
)

rule_source = node[:iptables_persistent][:rules_file].kind_of?(String) ? node[:iptables_persistent][:rules_file] : node[:hostname]

remote_file "/etc/iptables/rules.v4" do
  source "#{__dir__}/files/rules-#{rule_source}.v4"
  owner 'root'
  group 'root'
  mode  '0644'
end

remote_file "/etc/iptables/rules.v6" do
  source "#{__dir__}/files/rules-#{rule_source}.v6"
  owner 'root'
  group 'root'
  mode  '0644'
end
