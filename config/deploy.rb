# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'hue'
set :repo_url, 'git@github.com:stephanvane/hue.git'

set :rbenv_ruby, '2.1.3'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# namespace :deploy do

#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       # Your restart mechanism here, for example:
#       # execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end

#   after :publishing, :restart

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end

# end

namespace :clockwork do
  desc 'Start clockwork'
  task :start do
    on roles(:all) do
      within current_path do
        with rails_env: :production do
          execute(:bundle, 'exec clockworkd --log start')
        end
      end
    end
  end

  desc 'Restart clockwork'
  task :restart do
    on roles(:all) do
      within current_path do
        with rails_env: :production do
          execute(:bundle, 'exec clockworkd --log restart')
        end
      end
    end
  end

  desc 'Stop clockwork'
  task :stop do
    on roles(:all) do
      within current_path do
        with rails_env: :production do
          execute(:bundle, 'exec clockworkd --log stop')
        end
      end
    end
  end
end

after 'puma:start', 'clockwork:start'
after 'puma:stop', 'clockwork:stop'
after 'puma:restart', 'clockwork:restart'
