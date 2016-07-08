execute 'curl https://s3-ap-northeast-1.amazonaws.com/sorah.jp/packaging/debian/C3FF3305.pub.txt | apt-key add - ' do
  not_if "apt-key list | grep '/C3FF3305'"
end

file "/etc/apt/sources.list.d/nekomit.list" do
  content <<-EOF
deb https://dl.bintray.com/nekomit/deb-originals #{node[:release]} main
  EOF

  owner 'root'
  group 'root'
  mode  '0644'

  notifies :run, "execute[apt-get update]", :immediately
end
