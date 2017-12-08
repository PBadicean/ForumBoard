# config valid for current version and patch releases of Capistrano
lock "~> 3.10.0"

set :application, "forumboard"
set :repo_url, "https://github.com/PBadicean/ForumBoard.git"
set :sidekiq_queue, %w[default mailers]
# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/forumboard"
set :deploy_user, 'deployer'

# Default value for :linked_files is []
append :linked_files, "config/database.yml", ".env"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache",
                     "tmp/sockets", "vendor/bundle",
                     "public/system", "public/uploads"
set :passenger_restart_with_touch, true

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
