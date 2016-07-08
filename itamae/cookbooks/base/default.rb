%w(
  git-core
  htop dstat
  curl
).uniq.each do |pkg|
  package pkg do
  end
end

include_cookbook 'sshd'

include_cookbook 'build-essential'
include_cookbook 'rbenv'
include_cookbook 'nodejs'
include_cookbook 'dj-user'

include_recipe './systemd_logind.rb'

directory '/usr/share/djbu' do
  owner 'root'
  group 'root'
  mode  '0755'
end
