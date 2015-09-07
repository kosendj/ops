# config valid only for current version of Capistrano
# lock '3.4.0'

# set :application, 'my_app_name'
set :repo_url, 'git@github.com:kosendj/ops.git'

set :sudo_password, -> { ask('Your sudo password:', nil, echo: false) }

module ::Capistrano
  module DSL
    def sudo(*args)
      if args.last.is_a?(Hash)
       args << args.pop.merge(sudo_handler)
      else
        args << sudo_handler
      end
      execute :sudo, *args
    end

    def sudo_handler
        abort 'Enter sudo password' unless fetch(:sudo_password)
        {
          interaction_handler: {
            /^\[sudo\] password for (.+?):/ => "#{fetch(:sudo_password)}\n",
          }
        }
    end
  end
end



# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# namespace :deploy do
# 
#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end
# 
# end
#
server('cyan.box.ops.kosendj-bu.in',
  roles: %w(itamae),
  name: 'cyan',
)

server('retoree.box.ops.kosendj-bu.in',
  roles: %w(itamae),
  name: 'retoree',
  itamae_ssh: true,
)
