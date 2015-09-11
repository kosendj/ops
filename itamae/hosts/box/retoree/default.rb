node[:platform] = :onpremise

node.reverse_merge!(
  openvpn: {
    remote: 'rosia.pub-ops.kosendj-bu.in',
    key: node[:secrets][:'openvpn-ca_retoree_key'],
    cert: <<-EOF,
-----BEGIN CERTIFICATE-----
MIIDSTCCAjGgAwIBAgIBATANBgkqhkiG9w0BAQsFADAdMRswGQYDVQQDDBJrb3Nl
bmRqIG9wZW52cG4gY2EwHhcNMTUwOTExMTcxMjIyWhcNMjUwOTA4MTcxMjIyWjAS
MRAwDgYDVQQDDAdyZXRvcmVlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAywReXwhNjBoeaHSe88p3oTaVm7eiTEaw6klI5z7Dkz23GY+5VHHUxYIAGdz7
dYKF98YfB6MeCfqhm8mE02upMlwvN+7b2lPu3tFzImDEtTd8z/AI4gS/ROQwPPI1
1Hv5D6BCVqC2sTrSop0O2TcxVufG8PzFDBOdO8PVvVSvZi5EHAcpTShPqjSRjl3d
uDJpkoXKtXNMI1zfhca7Usk/f0wv96r6kNlV7+86ziNPBuASUPiAs/NdA7kSzYg2
HBBvm69Hd5bquWQ2V1obm0r7HwnT6zKEB3U3jGy0LEeYz5VKnrqBZQlTyYWkeCAd
cuZIZ4NshDS5bsk2gxKZlbQdPQIDAQABo4GeMIGbMAkGA1UdEwQCMAAwHQYDVR0O
BBYEFBgsqbhxYcsePZ/FWtuFdQjvVVDyME0GA1UdIwRGMESAFH1z+GvFJ+bYYU14
/Jjil3BP7KDZoSGkHzAdMRswGQYDVQQDDBJrb3NlbmRqIG9wZW52cG4gY2GCCQCF
G+NI/fxruDATBgNVHSUEDDAKBggrBgEFBQcDAjALBgNVHQ8EBAMCB4AwDQYJKoZI
hvcNAQELBQADggEBAH7VOvZkXUiTtFs1axAt+vL7ho+p8A8gwus3q2+jmaZrRXyR
mwtEwf8YYgCklkNnSHV7sc+TthhjxbRg8Xh4gm8QLsFNIvlaS51PAPzl56cDCzht
ZGmc/dv01gGBwLYSJX1FK9ykl+NorEwp5XpvwWtURY42dkZhYiXHlvJRzdU5avhU
m+7OM3sCrU5iSVV1qDkhYHowSLus+yrMgkZ8OOJuhDqIEt+DCvr5pgHS4yp0/kPr
94N1EIVH6E6ZXNb7piqypr+qn4rVLONxmq9N29mFY/S/XORSpONh40SbEDE8lY5s
yLA7fztjYgBOd3bZ3tm9t3ctArQPAWVzcpRh7w8=
-----END CERTIFICATE-----
    EOF
  }
)

include_recipe '../base/default.rb'
include_cookbook 'nginx'

include_role 'box-router'
include_role 'openvpn-client'

include_role 'gjcase_storage'
include_role 'camo'
