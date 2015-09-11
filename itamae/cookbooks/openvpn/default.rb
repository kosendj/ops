package 'openvpn' do
end

remote_file '/etc/openvpn/ca.crt' do
  owner 'root'
  group 'root'
  mode  '0444'
end


file '/etc/openvpn/psk.key' do
  content node[:secrets][:openvpn_psk].concat(?\n)
  owner 'root'
  group 'root'
  mode  '0440'
end

