#set :stages, %w(production staging)
#set :default_stage, "staging"
##require 'capistrano/ext/multistage'
#set :application, "ServerTest"
#set :repository, "https://github.com/mrg-rgrzesik/ServerTest.git"
#set :scm, :git
#
#set :deploy_to, "/var/www/ServerTest"
#
#desc "check production task"
#task :check_production do
#
#  if stage.to_s == "production"
#    puts " \n Are you REALLY sure you want to deploy to production?"
#    puts " \n Enter the password to continue\n "
#    password = STDIN.gets[0..7] rescue nil
#    if password != 'mypasswd'
#      puts "\n !!! WRONG PASSWORD !!!"
#      exit
#    end
#
#  end
#
#end
#
#before "deploy", "check_production"

set :application, 'ServerTest'
set :repo_url, 'https://github.com/mrg-rgrzesik/ServerTest.git'
set :branch, "master"

set :deploy_to, '/var/www/html/ServerTest'
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end