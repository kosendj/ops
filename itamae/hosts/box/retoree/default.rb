node[:platform] = :onpremise

include_recipe '../base/default.rb'
include_cookbook 'nginx'

include_role 'box-router'
include_role 'gjcase_storage'
include_role 'camo'
