source "https://rubygems.org"

ruby '2.2.4'

gem "active_type", ">= 0.3.2"
gem "autoprefixer-rails", ">= 5.0.0.1"
gem "bcrypt", "~> 3.1.7"
gem "bootstrap_form", "~> 2.3"
gem "bootstrap-sass", "~> 3.3"
gem "coffee-rails", "~> 4.1.0"
gem "dotenv-rails", ">= 2.0.0"
gem "font-awesome-rails"
gem "jquery-rails"
gem "jquery-turbolinks"
gem "mail", ">= 2.6.3"
gem "marco-polo"
gem "pg", "~> 0.15"
gem "rails", "4.2.5"
gem "redis-namespace"
gem "sass-rails", "~> 5.0"
gem "secure_headers", "~> 2.5"
gem "sidekiq"
gem "sinatra", ">= 1.3.0", :require => false
gem "turbolinks", ">= 2.5.2"
gem "geocoder"

group :production, :staging do
  gem "unicorn"
  gem "unicorn-worker-killer"
  gem "rails_12factor"
end

group :development do
  gem "annotate", ">= 2.5.0"
  gem "awesome_print"
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
  gem "listen"
  gem "quiet_assets"
  gem "rack-livereload"
  gem "spring"
  #gem "xray-rails", ">= 0.1.18"
  gem "xray-rails"
end

group :development, :test do
  gem "simplecov", :require => false
  gem 'byebug'
end
group :development do
  gem "airbrussh", :require => false
  gem "brakeman", :require => false
  gem "bundler-audit", :require => false
  gem "capistrano", "~> 3.4", :require => false
  gem "capistrano-bundler", :require => false
  gem "capistrano-mb", ">= 0.22.2", :require => false
  gem "capistrano-nc", :require => false
  gem "capistrano-rails", :require => false
  gem "guard", ">= 2.2.2", :require => false
  gem "guard-livereload", :require => false
  gem "guard-minitest", :require => false
  gem "rb-fsevent", :require => false
  gem "sshkit", "~> 1.8", :require => false
  gem "terminal-notifier", :require => false
  gem "terminal-notifier-guard", :require => false
  gem "thin", :require => false
end

group :test do
  gem "capybara"
  gem "connection_pool"
  gem "launchy"
  gem "minitest-reporters"
  gem "mocha"
  gem "poltergeist"
  gem "shoulda-context"
  gem "shoulda-matchers", ">= 3.0.1"
  gem "test_after_commit"
end

