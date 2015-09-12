node[:platform] = :onpremise

node.reverse_merge!(
  mysqld: {
    server_id: '2',
  },
  gjcase: {
    aws_access_key_id: node[:secrets][:'aws-gjcase_cyan-access_key_id'],
    aws_secret_access_key: node[:secrets][:'aws-gjcase_cyan-secret_access_key'],
  },
)

include_recipe '../base/default.rb'
include_cookbook 'nginx'

include_cookbook 'mysql-client'
include_cookbook 'redis-client'

include_role 'mysql-server'
include_role 'redis-server'

include_role 'gjcase'
include_role 'gj'
