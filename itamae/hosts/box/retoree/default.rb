node[:platform] = :onpremise

include_cookbook 'base'
include_cookbook 'nginx'

include_role 'box-router'
include_role 'gjcase_storage'
include_role 'camo'
