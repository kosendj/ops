include_cookbook 'pip'

execute 'pip install awscli' do
  not_if 'test -x /usr/local/bin/aws'
end

link '/usr/bin/aws' do
  to '/usr/local/bin/aws'
end

define :aws_profile, owner: 'dj', access_key_id: nil, secret_access_key: nil, region: 'ap-northeast-1' do
  name = params[:name]
  target_user = params[:owner]
  access_key_id = params[:access_key_id]
  secret_access_key = params[:secret_access_key]
  region = params[:region]

  case target_user
  when 'root'
    home = '/root'
  else
    home = "#{home}"
  end

  directory "#{home}/.aws" do
    owner target_user
    group target_user
    mode  '0755'
  end

  file "#{home}/.aws/config" do
    action :create
    owner target_user
    group target_user
    mode  '0644'
  end

  file "#{home}/.aws/credentials" do
    action :create
    owner target_user
    group target_user
    mode  '0600'
  end

  file "#{home}/.aws/config" do
    action :edit
    block do |content|
      ini = <<-EOF
[profile #{name}]
region=#{region}
s3 =
  signature_version = s3v4
      EOF

      regex_name = Regexp.escape name
      if /^\[profile #{regex_name}\]$/ === content
        content.gsub!(/^\[profile #{regex_name}\]$.+?(^\[|\z)/m, [ini, "\n", '\1'].join(''))
      else
        content.chomp!
        content << "\n" << ini.chomp << "\n"
      end
    end
  end

  if access_key_id && secret_access_key
    file "#{home}/.aws/credentials" do
      action :edit
      block do |content|
        ini = <<-EOF
[#{name}]
aws_access_key_id=#{access_key_id}
aws_secret_access_key=#{secret_access_key}
        EOF

        regex_name = Regexp.escape name
        if /^\[#{regex_name}\]$/ === content
          content.gsub!(/^\[#{regex_name}\]$.+?(^\[|\z)/m, [ini, "\n", '\1'].join(''))
        else
          content.chomp!
          content << "\n" << ini.chomp << "\n"
        end
      end
    end
  end
end
