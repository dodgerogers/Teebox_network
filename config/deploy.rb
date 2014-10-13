require "bundler/capistrano"
require "delayed/recipes"

server "104.131.19.133", :web, :app, :db, primary: true
role :whenever, "104.131.19.133"

set :application, "teebox"
set :user, "andrew"
set :deploy_to, "/home/#{user}/rails/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"

set :scm, :git 
set :repository,  "https://github.com/dodgerogers/Teebox_network"
set :branch, "master"

set :whenever_roles, "whenever"
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :keep_releases, 2

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

before "deploy", "deploy:check_revision"
after "deploy", "deploy:cleanup" # only keep the last 5 releases
after "deploy", "delayed_job:restart"
after "deploy:update_code", "deploy:migrate"
after "deploy:setup", "deploy:setup_config"
after "deploy:finalize_update", "deploy:symlink_config"
after "deploy:finalize_update", "deploy:assets:precompile"

# delayed jobs workers
#after "deploy:stop",    "delayed_job:stop"
#after "deploy:start",   "delayed_job:start"
#after "deploy:restart", "delayed_job:restart"

namespace :deploy do
  namespace :assets do
    task :precompile, :only => { :primary => true } do
      run_locally "bundle exec rake assets:precompile"
      servers = find_servers :roles => [:app], :except => { :no_release => true }
      servers.each do |server|
        run_locally "rsync -av ./public/#{assets_prefix}/ #{user}@#{server}:#{current_path}/public/#{assets_prefix}/"
      end
      run_locally "rm -rf public/#{assets_prefix}"
    end
  end
  
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end
  
  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    sudo "mkdir -p #{shared_path}/config"
    puts "Now edit the config files in #{shared_path}"
  end
  
  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
    sudo "mkdir -p #{release_path}/public/uploads/tmp/screenshots"
    sudo "chmod -R 777 #{release_path}/public/uploads"
  end
  
  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes"
      exit
    end
  end
end
