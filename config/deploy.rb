require "bundler/capistrano"

server "162.243.40.138", :web, :app, :db, primary: true

set :application, "Teebox_network"
set :user, "andrew"
set :deploy_to, "/home/rails/Teebox_network"
set :deploy_via, :remote_cache
set :use_sudo, true

set :scm, :git 
set :repository,  "https://github.com/dodgerogers/#{application}"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"
