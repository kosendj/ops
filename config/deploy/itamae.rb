require 'json'
require 'yaml'

set :deploy_to, "/tmp/itamae-cache.#{ENV['REMOTE_USER'] || ENV['USER']}"
set :remote_user, -> { ENV['REMOTE_USER'] || 'dj' }
set :itamae_version, '1.4.3+20150728074102-1'

set :pty, true

task :rsync do
 local_itamae_path = File.join(__dir__, '..', '..', 'itamae')
  on roles(:itamae) do |srv|
    next if srv.properties.itamae_ssh
    run_locally do
      user = ENV['REMOTE_USER'] || (srv.ssh_options && srv.ssh_options[:user]) || 'dj'
      user_opt = user ? "#{user}@" : ""
      execute "rsync -az --copy-links --copy-unsafe-links --delete --exclude='*.sw?' #{local_itamae_path} #{user_opt}#{srv}:#{deploy_to}"
    end
    execute "chmod 600 #{deploy_to}/itamae/secrets/keys/*"
  end
end

%i!apply-immediately dry-run!.each do |task_name|
  task task_name => [:rsync, :update_itamae_package] do
    seq = false
    on roles(:itamae), in: :sequence do
      if host.properties.itamae_ssh
        seq = true
        puts "Running in sequence (itamae_ssh hosts are included)"
      end
    end

    opts = seq ? {in: :sequence} : {}
    on roles(:itamae), opts do
      root_dir = host.properties.itamae_ssh ? '.' : deploy_to
      recipe_path = File.join(root_dir, "itamae/hosts/#{host.properties.zone}/#{host.properties.name}/default.rb")

      itamae_args = []
      itamae_args << "--dry-run" if task_name == :"dry-run"
      itamae_args << "--log-level" << ENV['ITAMAE_LOG'] if ENV['ITAMAE_LOG']
      # itamae_args << "-j #{File.join(deploy_to, fetch(:variables_json_path))}"
      itamae_args << File.join(root_dir, "itamae/site.rb")
      itamae_args << recipe_path

      if host.properties.itamae_ssh
        itamae_cmd = [*%w(itamae ssh), "--host", host.to_s, "--user", fetch(:remote_user), *itamae_args]
        puts "$ #{itamae_cmd.join(' ')}"
        unless system(*itamae_cmd)
          raise 'itamae failed'
        end
      else
        with term: 'xterm' do
          sudo "/opt/itamae/embedded/bin/itamae", "local", *args
        end
      end

      if task_name != :'dry-run'
        current_revision = ''
        run_locally do
          current_revision = capture('git rev-parse HEAD')
        end
        sudo :sh, "-c 'mkdir -p /var/lib/itamae; echo #{current_revision} > /var/lib/itamae/last_revision'"
      end
    end
  end
end

task :apply do
  invoke "dry-run"
  print "Sure? (y/N): "
  case $stdin.gets.chomp
  when /^no?$/i
    puts "Cancelled"
  when /^y(?:es)?$/i
    puts "Continue"
    invoke "apply-immediately"
  end
end

task :prepare => [:set_hostname, :install_itamae_package] do
end

task :install_itamae_package do
  on roles(:itamae), in: :sequence do |srv|
    next if srv.properties.itamae_ssh

    itamae_cmd = "itamae ssh --host #{srv} --user #{fetch(:remote_user)} itamae/site.rb itamae/hosts/#{srv.properties.zone}/base/prepare.rb"
    puts "$ #{itamae_cmd}"
    unless system(itamae_cmd)
      raise 'itamae prepare failed'
    end
  end
end

task :update_itamae_package do
  on roles(:itamae) do |srv|
    next if srv.properties.itamae_ssh
    cmd = <<-EOC
/bin/bash -c 'dpkg-query -s itamae | grep -E "^Version: #{Regexp.escape(fetch(:itamae_version))}$" || apt-get update && env DEBIAN_FRONTEND='noninteractive' apt-get -y install itamae=#{fetch(:itamae_version)}'
    EOC
    unless sudo(cmd, raise_on_non_zero_exit: false)
      invoke "prepare"
    end
  end
end

task :set_hostname do
  on roles(:itamae) do |srv|
    # set hostname
    current_hostname = capture('hostname')
    if current_hostname.chomp != srv.properties.name
      sudo "hostname #{srv.properties.name}"
      sudo "sh -c 'echo -n #{srv.properties.name} > /etc/hostname'"
    end
  end
end
