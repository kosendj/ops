remote_file "/usr/bin/kdj-setup-rbenv" do
  owner 'root'
  group 'root'
  mode  '0755'
end

remote_file "/usr/bin/kdj-install-ruby" do
  owner 'root'
  group 'root'
  mode  '0755'
end

execute "/usr/bin/kdj-setup-rbenv" do
  user 'root'
  not_if "test -d /usr/share/rbenv"
end

execute "/usr/bin/kdj-install-ruby 2.2.2 2.2.0" do
  user 'root'
  not_if "test -d /usr/share/rbenv/versions/2.2.2"
end

file "/usr/share/rbenv/version" do
  content "2.2\n"
  owner 'root'
  group 'root'
  mode  '0644'
end
