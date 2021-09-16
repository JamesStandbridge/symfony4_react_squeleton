# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "moins7.com"
set :repo_url, "git@github.com:JamesStandbridge/Moins7CloudERP.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/psnh1702/apps/app.moins7.com"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, ".env"

# Default value for linked_dirs is []
append :linked_dirs, "public/uploads"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

before "composer:run", "postdeploy:assets" 

namespace :postdeploy do
	task :assets do
		on release_roles(fetch(:symfony_deploy_roles)) do
			within release_path do
				execute "mkdir -p config/jwt"
				execute "openssl genpkey -out config/jwt/private.pem -aes256 -algorithm rsa -pkeyopt rsa_keygen_bits:4096 -pass pass:admin"
				execute "openssl pkey -in config/jwt/private.pem -out config/jwt/public.pem -pubout -passin pass:admin"
				execute :npm, "install --legacy-peer-deps"
				execute :npm, "run build"
			end
		end
	end
end
