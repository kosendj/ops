node.reverse_merge!(
  mysqld: {
    server_id: '1',
  },
  gjcase: {
    private_mode: true,
    aws_access_key_id: node[:secrets][:'aws-gjcase_rosia-access_key_id'],
    aws_secret_access_key: node[:secrets][:'aws-gjcase_rosia-secret_access_key'],
  },
  openvpn: {
    key: node[:secrets][:'openvpn-ca_rosia_key'],
    cert: <<-EOF,
-----BEGIN CERTIFICATE-----
MIIDRzCCAi+gAwIBAgIBAjANBgkqhkiG9w0BAQsFADAdMRswGQYDVQQDDBJrb3Nl
bmRqIG9wZW52cG4gY2EwHhcNMTUwOTExMTcxNTQzWhcNMjUwOTA4MTcxNTQzWjAQ
MQ4wDAYDVQQDDAVyb3NpYTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AMDJTqk7k4PtWEsxtlm0lXfXqIQFe3wEqXRsCtxrzKBSZQZNrra8XjyMr1jWrTV9
oyaB/yNzHgFyQB5lKZAS457UMUtKYHUNaHfS+Xg3t/A3X0x9PEcQjAt8BFNPSP5B
bQYpyh5/UZ3EhmPgaoYGz+ewrKC2dl4FGsEXKoQpzOjP5p1Nbkgi7IHwGtNGevDJ
iJm/NrRAiSBY9rKaryA4Thgcmbio+lE297QRj7c5LlVKyfWWMj2YnKFA4AMyx6YT
jnhWmCQq4KGSFGf766aZWdCMjpRi1Tmo6rBg/pton3bfKnOCkUUHRSYDqhJhSmbV
MA7JmJeI6yI0J+uZPDZk0oMCAwEAAaOBnjCBmzAJBgNVHRMEAjAAMB0GA1UdDgQW
BBTcr7iF4RLSLm6FCtN4a6LXvDiVCzBNBgNVHSMERjBEgBR9c/hrxSfm2GFNePyY
4pdwT+yg2aEhpB8wHTEbMBkGA1UEAwwSa29zZW5kaiBvcGVudnBuIGNhggkAhRvj
SP38a7gwEwYDVR0lBAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMA0GCSqGSIb3
DQEBCwUAA4IBAQCKwxxwjGcX/ee+tAKBgEWiNnxnlMmEu58TDHtoYdsEPo0hFw9h
kznPYYQSYIz8hX6uXOvUtunB3aTVtbjk7QIvrhS6sz8CLPak+RIw8GUmAQsqHYOc
lSjAJRTh5ORq6eWxZ65TtV/tMK5MUYoQltEZNS7fmmbnq6iEdVwzRky2qDXMfG9Y
sC60Kg0z6DHAK9fMRnAHj+gOGag4kn3zq0hpmYYRu8a6T7/v+Plt9r5CBCLjT1GY
/5RA4AFTsJZEC+zhHDbiExHLK0DXTW7OyPCDfSW8yaRSMIez8emKIpj3I3Ht93Rs
fBu1a7vzck8C2L3c9iT6OSh0Y9jD3Cfk4hyR
-----END CERTIFICATE-----
    EOF
  }
)

include_recipe '../base/default.rb'

include_cookbook 'iptables-persistent'

remote_file '/etc/iptables/rules.v4' do
  owner 'root'
  group 'root'
  mode  '0644'
end

remote_file '/etc/iptables/rules.v6' do
  owner 'root'
  group 'root'
  mode  '0644'
end

include_role 'mysql-server'
include_role 'redis-server'

include_role 'internal-dns'
include_role 'dns-cache'

include_role 'openvpn-server'

include_role 'nginx-omniauth-adapter'
include_role 'gjcase'
include_role 'gj'
include_role 'camo'
