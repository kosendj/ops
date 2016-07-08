node.reverse_merge!(
  gjcase: {
    aws_access_key_id: node[:secrets][:'aws-gjcase_cyan-access_key_id'],
    aws_secret_access_key: node[:secrets][:'aws-gjcase_cyan-secret_access_key'],
  },
)

