lock '~> 3.10.2'

set :application, 'personal-finance'
set :repo_url, 'https://github.com/marderer/personal-finance'

set :use_sudo, true
set :branch, 'master'

set :deploy_to, '/var/www/personal-finance'

set :linked_dirs, fetch(:linked_dirs, []).push(
  'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/packs', 'node_modules'
)

set :pty, true
set :ssh_options, {forward_agent: true, auth_methods: %w[publickey], keys: %w[personal-finance.pem]}
set :default_env, { 'NODE_ENV' => 'production' }
