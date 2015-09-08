node.reverse_merge!(
  dj_user: {
    authorized_keys: [:kosendj],
  },
)

known_ssh_keys = {
  kosendj: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOmRR4st2sEtU8/iPOLtkRIfCpfpYxMDI6aXsC5Z3mT/W1JeUwzh1nFWpJxva1VKKSYfVccA96ZW15E/BsHeD0uVW7r/5ZTz1PqU5+U4sXbOhjjgT7nvQNdtPUyd2HaEf/D5ggALaeyMnPQGPButnIfY/S6qVwJl66C5blJdIWyjI/7sKTOCdfWpr4IOmvPyk//CGkYMC2hHYcQfOfObp2gouwE9zVcbrRbUnvZnsx804uZDyznJGfkE5zg6mBmKMLQUlCRugNTONn/0ic7Bk/oTuvlIVsgBCuJaKw8B37AsbhzqSHhYb1q/j3ncjs5SPy2gFq+IBchmA6jywf51MR kosendj-20150906',
}

user 'dj' do
  uid 1000
  gid 1000
  home '/home/dj'
  create_home true
end

directory '/home/dj' do
  owner 'dj'
  group 'dj'
  mode  '0755'
end

directory '/home/dj/.ssh' do
  owner 'dj'
  group 'dj'
  mode  '0700'
end

ssh_keys = node[:dj_user][:authorized_keys].map { |_| _.is_a?(Symbol) ? known_ssh_keys[_] : _ }
file '/home/dj/.ssh/authorized_keys' do
  content ssh_keys.join(?\n).concat(?\n)
  owner 'dj'
  group 'dj'
  mode  '0600'
end
