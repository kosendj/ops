node[:platform] = :onpremise

include_recipe '../base/default.rb'
include_cookbook 'nginx'

include_cookbook 'mysql-client'
include_cookbook 'mysql-server'

include_cookbook 'redis-client'
include_cookbook 'redis-server'

include_role 'gjcase'
include_role 'gj'
