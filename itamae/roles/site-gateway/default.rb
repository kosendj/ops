node.reverse_merge!(
  site_gateway: {
    connections: {
      # conn_id: { leftid: '', rightid: '', right: 'global-ip', inner_left: '169.254.225.x/30', inner_right: '169.254.225.x/30', psk: '0s{base64}', ike: 'aes256gcm128-sha256-ecp521', esp: 'aes128gcm96-sha1' },
    },
  },
)

include_cookbook 'strongswan'

template '/etc/strongswan.d/charon.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
end

directory '/usr/share/djbu/site-gateway' do
  owner 'root'
  group 'root'
  mode  '0755'
end

remote_file '/usr/share/djbu/site-gateway/ipsec-updown.sh' do
  owner 'root'
  group 'root'
  mode  '0755'
end

remote_file '/usr/share/djbu/site-gateway/ipsec-updown-privileged.sh' do
  owner 'root'
  group 'root'
  mode  '0755'
end

remote_file '/etc/sudoers.d/ipsec-updown' do
  owner 'root'
  group 'root'
  mode  '0600'
end

template '/etc/ipsec.secrets' do
  owner 'root'
  group 'root'
  mode  '0640'
end

template '/etc/ipsec.conf' do
  owner 'root'
  group 'root'
  mode  '0644'
end

service 'strongswan' do
  action :enable
end


