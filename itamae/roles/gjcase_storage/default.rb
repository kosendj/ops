include_cookbook 'nginx'
include_cookbook 'awscli'

remote_file '/etc/nginx/sites-enabled/storage' do
  owner 'root'
  group 'root'
  mode  '0644'
end

remote_file '/usr/bin/djbu-pull-gjcase-storage' do
  owner 'root'
  group 'root'
  mode  '0755'
end

if node[:platform] != :ec2
  aws_profile 'gjcase_storage' do
    access_key_id node[:secrets][:'aws-gjcase_box-access_key_id']
    secret_access_key node[:secrets][:'aws-gjcase_box-secret_access_key']
  end
end
