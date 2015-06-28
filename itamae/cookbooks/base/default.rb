%w(
git-core
  htop dstat
  binutils build-essential cpp cpp-4.9 debhelper dh-apparmor dpkg-dev g++ g++-4.9 gcc gcc-4.9 gettext intltool-debian libasan1 libatomic1 libc-dev-bin libc6-dev libcilkrts5 libcloog-isl4 libcroco3 libdpkg-perl libgcc-4.9-dev libgomp1 libisl13 libitm1 libmpc3 libquadmath0
  libssl-dev
  libstdc++-4.9-dev libubsan0 libunistring0 linux-libc-dev make po-debconf
  autoconf automake autopoint autotools-dev bison chrpath dh-autoreconf libbison-dev libffi-dev libgdbm-dev libgmp-dev libgmpxx4ldbl
  libjs-jquery libncurses5-dev libncursesw5-dev libreadline6-dev libruby2.1 libssl-dev libtinfo-dev libtool libyaml-0-2 libyaml-dev m4
  systemtap-sdt-dev zlib1g-dev
).uniq.each do |pkg|
  package pkg do
  end
end

include_cookbook 'rbenv'
include_cookbook 'nodejs'
