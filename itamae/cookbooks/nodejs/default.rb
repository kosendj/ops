package "nodejs" do
end

execute "update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10" do
  user 'root'
  not_if 'test -e /usr/bin/node'
end

package "npm" do
end
