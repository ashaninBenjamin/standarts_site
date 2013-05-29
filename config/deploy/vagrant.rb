set :branch, 'develop'
set :user, 'vagrant'
ssh_options[:keys] = '~/.vagrant.d/insecure_private_key'
ssh_options[:port] = 2222
set :deploy_to, "/home/vagrant/#{application}"

server '127.0.0.1', :app
server '127.0.0.1', :web
server '127.0.0.1', :db, primary: true

set :normalize_asset_timestamps, false
set :deploy_via, :remote_cache