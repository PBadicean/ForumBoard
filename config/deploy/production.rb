server '185.143.172.213', user: 'deployer', roles: %w{app db web}, primary: true

role :app, %w{deployer@185.143.172.213}
role :web, %w{deployer@185.143.172.213}
role :db,  %w{deployer@185.143.172.213}

set :rails_env, :production
set :stage, :production

set :ssh_options, {
  keys: %w(/Users/PBadichan/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey password),
  port: 4321
}
