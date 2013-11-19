source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use postgresql as the database for Active Record
gem 'pg', '0.17.0'

# Use SCSS for stylesheets
gem 'sass-rails', '4.0.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '2.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby, group: [:developmen, :test]

# Use jquery as the JavaScript library
gem 'jquery-rails', '3.0.4'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '1.3.0'

# Gon lets you pass variable values to js.
gem 'gon', '4.1.1'

# Spine integration
gem 'spine-rails', '0.1.2'
gem 'json2-rails', '1.0.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '1.5.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '3.1.2'

# Use debugger
gem 'debugger', group: [:development, :test]

group :development do
  # Configuration
  gem 'dotenv-rails'

  # Development & testing
  gem 'meta_request'
  gem 'guard'
  gem 'rack-livereload'
  gem 'spork-rails'
  gem 'spork-testunit'

  # Guards
  gem 'guard-livereload'
  gem 'guard-spork'
end

# Caching
gem 'rack-cache', '1.2'
gem 'dalli', '2.6.4'
gem 'kgio', '2.8.1'

# Authentication & Authorization
gem 'warden', '1.2.3'
gem 'authority', '2.9.0'

# File upload
gem 'dragonfly', '0.9.15'

# Background tasks
gem 'delayed_job_active_record', '4.0.0'

# ActiveRecord
gem 'squeel', '1.1.1'
gem 'searchlight', '1.3.1'
gem 'has_eav', git: 'git@github.com:hazah/has_eav.git', tag: 'v1.2.2'

# ActionController
gem 'decent_exposure', '2.3.0'

# Pagination
gem 'kaminari', '0.14.1'

# Friendly URL Paths
gem 'slugalicious', '2.1.0'

## The production environment will specify the versions for the following.
## The idea is to keep current!

group :production do
  # Use unicorn as the app server in production
  gem 'unicorn'

  # This is necessary to deploy on heroku
  gem 'rails_12factor'

  # Heroku specific memcached for production
  gem 'memcachier'
end
