require 'infrataster/rspec'

Infrataster::Server.define(
  :retoree,
  '172.19.224.0/19',
  from: :retoree,
  ssh: Net::SSH::Config.for('retoree.box.ops.kosendj-bu.in'),
)

# Infrataster::Server.define(
#   :cyan,
#   '172.19.128.0/19',
#   from: :retoree,
#   ssh: Net::SSH::Config.for('cyan.box.ops.kosendj-bu.in'),
# )
