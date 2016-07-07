%w(
  binutils build-essential
  libssl-dev
  make
  autoconf automake autopoint autotools-dev bison chrpath dh-autoreconf libbison-dev libffi-dev libgdbm-dev libgmp-dev
  libjs-jquery libncurses5-dev libncursesw5-dev libreadline6-dev libssl-dev libtinfo-dev libtool libyaml-0-2 libyaml-dev m4
  systemtap-sdt-dev zlib1g-dev
).each do |pkg|
  package pkg do
  end
end
