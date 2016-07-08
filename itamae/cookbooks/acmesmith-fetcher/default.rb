node.reverse_merge!(
  acmesmith_fetcher: {
    aws_profile: 'acmesmith_r',
    aws_region: 'ap-northeast-1',
    aws_s3_bucket: 'kosendj-acme/private-prod',
    passphrase: node[:secrets][:acmesmith_certificate_key_passphrase],
    certificates: {
      "misc.kosendj-bu.in" => {},
    },
  }
)

include_cookbook 'awscli'

directory '/etc/ssl/own' do
  owner 'root'
  group 'root'
  mode  '0755'
end

remote_file '/usr/bin/djbu-pull-acmesmith' do
  owner 'root'
  group 'root'
  mode  '0755'
end

file '/etc/djbu-acmesmith-fetcher.json' do
  content "#{node[:acmesmith_fetcher].to_json}\n"
  owner 'root'
  group 'root'
  mode  '0600'
end

aws_profile node[:acmesmith_fetcher][:aws_profile] do
  owner 'root'
  if node[:platform] != :ec2
    access_key_id node[:secrets][:'aws-acmesmith_r-access_key_id']
    secret_access_key node[:secrets][:'aws-acmesmith_r-secret_access_key']
  end
end
