# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

# デプロイするアプリケーション名
set :application, 'mumu'

# cloneするgitのレポジトリ
set :repo_url, 'git@github.com:y-kazuya/kaikai.git'

# deployするブランチ。デフォルトはmasterなのでなくても可。
set :branch, 'master'

# deploy先のディレクトリ。
set :deploy_to, '/var/www/rails/kaikai'
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }




# シンボリックリンクをはるフォルダ。(※後述)
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')
# 保持するバージョンの個数(※後述)
set :keep_releases, 5

set :ssh_options, auth_methods: ['publickey'],
                  keys: ["/Users/kazuya/.ssh/kaikai_pro.pem"]

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# rubyのバージョン
set :rbenv_type, :user
set :rbenv_ruby, '2.5.3'

#出力するログのレベル。
set :log_level, :debug

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
