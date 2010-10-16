# Bundler Integration
# http://github.com/carlhuda/bundler/blob/master/lib/bundler/capistrano.rb
require 'bundler/capistrano'

# Application Settings
set :application,   "deprecateme"
set :user,          "deploy"
set :password,      "G:=%FXLYSBcM"
set :deploy_to,     "/home/#{user}/#{application}"
set :rails_env,     "production"
set :use_sudo,      false
set :keep_releases, 5

# Git Settings
set :scm,           :git
set :branch,        "master"
set :repository,    "git@github.com:railsrumble/rr10-team-286.git"
set :deploy_via,    :remote_cache

# Uses local instead of remote server keys, good for github ssh key deploy.
ssh_options[:forward_agent] = true

# Server Roles
role :web, "173.255.227.44"
role :app, "173.255.227.44"
role :db,  "173.255.227.44", :primary => true

# Passenger Deploy Reconfigure
namespace :deploy do
  desc "Restart passenger process"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} does nothing for passenger"
    task t, :roles => :app do ; end
  end
end