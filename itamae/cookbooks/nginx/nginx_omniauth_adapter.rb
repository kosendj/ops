node.reverse_merge!(
  nginx_omniauth_adapter: {
    host: 'auth.kosendj-bu.in',
    server: '172.19.0.1',
  },
)

template "/etc/nginx/utils/ngx_omniauth_enable_server.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
end

template "/etc/nginx/utils/ngx_omniauth_enable_location.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
end
