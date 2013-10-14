require "bundler/capistrano"
require "rvm/capistrano"

set :stages, %w{staging production}
set :default_stage, "production"

server "162.243.40.138", :web, :app, :db, primary: true

set :application, "Teebox_network"
set :user, "andrew"
set :scm, "git"
set :scm_passphrase, ""
set :repository, "https://github.com/dodgerogers/#{application}"
set :branch, "master"

set :deploy_to, "/home/rails/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  task :restart, roles: :app do
      run "touch #{current_path}tmp/restart.txt"
    end
  end
  after :finishing, 'deploy:cleanup'
end