node.reverse_merge!(
  sshd: {
    listen_port22: true,
  }
)

include_cookbook 'base'
