node[:platform] = :onpremise

include_cookbook 'base'
include_cookbook 'nginx'

include_cookbook 'mysql-client'
include_cookbook 'mysql-server'

include_cookbook 'redis-client'
include_cookbook 'redis-server'

include_role 'gjcase'
include_role 'gj'
