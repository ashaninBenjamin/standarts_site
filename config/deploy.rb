set :rvm_type, :system
set :stages, %w(vagrant)
set :default_stage, "vagrant"
require 'capistrano/ext/multistage'

set :application, "standards"
set :scm, :git
set :repository,  "git://github.com/ashaninBenjamin/standarts_site.git"

set :use_sudo, false
set :ssh_options, forward_agent: true
default_run_options[:pty] = true

namespace :deploy do
  desc "Copy database.yml.sample to database.yml"
  task :copy_db, roles: :app do
    run "cp #{release_path}/config/database.yml.sample #{release_path}/config/database.yml"
  end

  desc "Symlinks the database.yml"
  task :symlink_db, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Seed database data"
  task :seed_data do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake} db:seed"
  end
end

before 'deploy:finalize_update', 'deploy:copy_db'
before 'deploy:finalize_update', 'deploy:symlink_db'
after "deploy:update", "deploy:cleanup"