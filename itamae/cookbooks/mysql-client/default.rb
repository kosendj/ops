case node[:release]
when :vivid
  package 'mysql-client-5.6' do
  end
when :xenial
  package 'mysql-client-5.7' do
  end
end

%w(
 libmysqlclient-dev
).each do |pkg|
  package pkg do
  end
end
