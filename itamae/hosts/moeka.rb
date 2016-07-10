node.reverse_merge!(
  gjcase: {
    aws_access_key_id: node[:secrets][:'aws-gjcase_cyan-access_key_id'],
    aws_secret_access_key: node[:secrets][:'aws-gjcase_cyan-secret_access_key'],
  },
  site_gateway: {
    primary_ip: '172.19.224.1/28',
    connections: {
      moeka2akeno: {
        leftid: '@moeka.cnh.c.kosendj-bu.in',
        rightid: '@akeno.cnh.c.kosendj-bu.in',
        right: '150.95.130.37',
        ifname: 'cnh',
        inner_left: '169.254.225.2/30',
        inner_right: '169.254.225.1/30',
        static_routes: %w(172.20.0.0/21),
        mobike: true,
        mark: 10,
        psk: node[:secrets][:'site_gateway-psk'],
      },
    },
  },
)

