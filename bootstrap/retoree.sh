#!/bin/bash
set -e

if [ "$(hostname)" != "retoree" ]; then
  if [ "_${IGNORE_HOSTNAME_DIFFER}" = "1" ]; then
    echo "WARN: ignoring hostname difference (this machine is $(hostname))" 1>&2
  else
    echo 'run on retoree or force by IGNORE_HOSTNAME_DIFFER=1' 1>&2
    exit 1
  fi
fi

if [ "$(whoami)" != "root" ]; then
  echo 'run as root' 1>&2
  exit 1
fi

set -x

## ssh

systemctl enable ssh

mkdir -p ~dj/.ssh
chmod 700 ~dj/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOmRR4st2sEtU8/iPOLtkRIfCpfpYxMDI6aXsC5Z3mT/W1JeUwzh1nFWpJxva1VKKSYfVccA96ZW15E/BsHeD0uVW7r/5ZTz1PqU5+U4sXbOhjjgT7nvQNdtPUyd2HaEf/D5ggALaeyMnPQGPButnIfY/S6qVwJl66C5blJdIWyjI/7sKTOCdfWpr4IOmvPyk//CGkYMC2hHYcQfOfObp2gouwE9zVcbrRbUnvZnsx804uZDyznJGfkE5zg6mBmKMLQUlCRugNTONn/0ic7Bk/oTuvlIVsgBCuJaKw8B37AsbhzqSHhYb1q/j3ncjs5SPy2gFq+IBchmA6jywf51MR kosendj-20150906' > ~dj/.ssh/authorized_keys
chmod 600 ~dj/.ssh/authorized_keys
chown -R dj:dj ~dj/.ssh

## networking

if ! dpkg --status vlan | grep 'install ok installed'; then
  apt-get install -y vlan
fi

sum1="$(shasum /etc/network/interfaces|cut -d' ' -f 1)"
cat > /etc/network/interfaces <<-'EOF'
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet dhcp

auto eth0.1
iface eth0.1 inet static
  address 172.19.224.1
  netmask 255.255.224.0
auto eth0.100
iface eth0.100 inet static
  address 172.19.128.1
  netmask 255.255.224.0
auto eth0.200
iface eth0.200 inet static
  address 172.19.0.1
  netmask 255.255.224.0
EOF
sum2="$(shasum /etc/network/interfaces|cut -d' ' -f 1)"
if [ "${sum1}" != "${sum2}" ]; then
  systemctl restart networking
fi
