%w(
 mysql-client-5.6 libmysqlclient-dev
).each do |pkg|
  package pkg do
  end
end
