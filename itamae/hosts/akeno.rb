node.reverse_merge!(
  gjcase: {
    private_mode: true,
    aws_access_key_id: node[:secrets][:'aws-gjcase_rosia-access_key_id'],
    aws_secret_access_key: node[:secrets][:'aws-gjcase_rosia-secret_access_key'],
  },
  site_gateway: {
    primary_ip: '172.20.0.2/21',
    connections: {
      akeno2moeka: {
        leftid: '@akeno.cnh.c.kosendj-bu.in',
        rightid: '@moeka.cnh.c.kosendj-bu.in',
        #right: '',
        ifname: 'box',
        inner_left: '169.254.225.1/30',
        inner_right: '169.254.225.2/30',
        static_routes: %w(172.19.0.0/16),
        mark: 10,
        psk: node[:secrets][:'site_gateway-psk'],
      },
    },
  },
)

