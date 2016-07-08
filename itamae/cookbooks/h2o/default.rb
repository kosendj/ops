include_cookbook 'apt-source-nekomit'

package 'h2o-server' do
end

directory '/var/log/h2o' do
  owner 'root'
  group 'root'
  mode  '0755'
end
