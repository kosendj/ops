# packagecloud.io
apt_key "D59097AB"

file '/etc/apt/sources.list.d/itamae.list' do
  owner 'root'
  group 'root'
  mode  '0644'

  content <<-EOC
deb [arch=amd64] https://packagecloud.io/ryotarai/itamae/ubuntu/ trusty main
deb-src [arch=amd64] https://packagecloud.io/ryotarai/itamae/ubuntu/ trusty main
  EOC

  notifies :run, "execute[apt-get update]", :immediately
end

package 'itamae' do
  action :install
end

# workaround (sorah)
execute '/opt/itamae/embedded/bin/gem update --system' do
  only_if '/opt/itamae/embedded/bin/gem -v | grep ^1.8'
end
