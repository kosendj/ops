node.reverse_merge!(
  gjcase: {
    private_mode: true,
    aws_access_key_id: node[:secrets][:'aws-gjcase_rosia-access_key_id'],
    aws_secret_access_key: node[:secrets][:'aws-gjcase_rosia-secret_access_key'],
  },
)

