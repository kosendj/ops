include_cookbook 'h2o'

node.reverse_merge!(
  nginx_backed_h2o: {
    certificates: {
      '*.kosendj-bu.in' => 'misc.kosendj-bu.in',
    },
  },
)

template "/etc/h2o/h2o.conf" do
  owner 'root'
  group 'root'
  mode  '0644'
end

service 'h2o' do
  action [:enable, :start]
end
