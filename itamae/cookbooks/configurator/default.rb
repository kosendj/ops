node.reverse_merge!(
  configurator: {
    access_key_id: node[:secrets][:'aws-configurator-access_key_id'],
    secret_access_key: node[:secrets][:'aws-configurator-secret_access_key'],
    region: 'ap-northeast-1',
    bucket: 'kosendj-config',
  },
)

include_cookbook 'awscli'

aws_profile 'configurator' do
  access_key_id node[:configurator][:access_key_id]
  secret_access_key node[:configurator][:secret_access_key]
  region node[:configurator][:region]
end

directory '/home/dj/djbu-config' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

remote_file '/usr/bin/djbu-pull-config' do
  owner 'root'
  group 'root'
  mode  '0755'
end

execute '/usr/bin/djbu-pull-config' do
  user 'dj'
  only_if 'test "$(ls /home/dj/djbu-config | wc -l)" -lt 1'
end

remote_file '/etc/cron.d/djbu-configurator' do
  owner 'root'
  group 'root'
  mode  '0644'
end
