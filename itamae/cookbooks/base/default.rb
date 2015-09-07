%w(
  git-core
  htop dstat
  curl
).uniq.each do |pkg|
  package pkg do
  end
end

include_cookbook 'build-essential'
include_cookbook 'rbenv'
include_cookbook 'nodejs'

include_recipe './systemd_logind.rb'
