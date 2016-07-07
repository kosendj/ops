case node[:release]
when :vivid
  package 'mysql-server-5.6' do
  end
when :xenial
  package 'mysql-server-5.7' do
  end
else
  raise
end
