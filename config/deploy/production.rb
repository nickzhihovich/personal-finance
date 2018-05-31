server '13.59.53.131', user: 'ubuntu', roles: %w{web app db}
set :ssh_options, { forward_agent: true }
