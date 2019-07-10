server '52.196.243.252', user: 'ec2-user', roles: %w{app db web}

#デプロイするサーバーにsshログインする鍵の情報を記述
# set :ssh_options, keys: '~/.ssh/first_aws_rsa'