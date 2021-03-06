source 'https://rubygems.org'

gem 'rails', '4.1.4'

### OpenShift Online changes:

# Fix the conflict with the system 'rake':
gem 'rake', '~> 0.9.6'

# Support for databases and environment.
# Use 'sqlite3' for testing and development and mysql and postgresql
# for production.
#
# To speed up the 'git push' process you can exclude gems from bundle install:
# For example, if you use rails + mysql, you can:
#
# $ rhc env set BUNDLE_WITHOUT="development test postgresql"
#
group :development, :test do
  # gem 'jazz_hands' # better console
  gem 'sqlite3'
  gem 'minitest'
  gem 'thor'
  gem 'sinatra', '>= 1.3.0', :require => nil
  gem 'rspec-rails', '~> 3.0.0'
  gem 'rspec-collection_matchers', '~> 1.0.0'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'fuubar', '~> 2.0.0'
end

gem 'rspec-sidekiq', '~> 2.0.0', group: :test

# Add support for the MySQL
group :production, :mysql do
  gem 'mysql2'
end

group :production, :postgresql do
  gem 'pg'
end

### / OpenShift changes

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
# gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring' # ,        group: :development

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails', '~> 3.1.0.20140911'
gem 'bootstrap_form', '~> 2.2.0'
gem 'acts_as_list', '~> 0.4.0'
gem 'sidekiq', '~> 3.2.5'
gem 'nokogiri', '~> 1.6.3'
gem 'premailer-rails', '~> 1.8.0'
gem 'ckeditor', '~> 4.1.0'
gem 'paperclip', '~> 4.2.0'
gem 'validates_email_format_of', '~> 1.6.1'