include_cookbook 'nginx'

remote_file '/etc/nginx/sites-enabled/storage-s3' do
  owner 'root'
  group 'root'
  mode  '0644'
end
