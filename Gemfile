source 'https://rubygems.org'

# make heroku happy
group :production do
  ruby '2.0.0'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# use postgresql as the default databse
gem "pg", "~> 0.15.1"

# use twitter's bootstrap css styling
gem 'bootstrap-sass', '~> 2.3.2.0'

# use unicorn as the web server
gem 'unicorn', '~> 4.6.3'

# use has secure password in active model
gem 'bcrypt-ruby', '~> 3.0.0'

# quickly populate test database with fake data
gem 'faker', '1.0.1'

# paginate long lists (default page length 30)
gem 'will_paginate', '~> 3.0.4'
gem 'bootstrap-will_paginate', '~> 0.0.9'

# use awesome print to improve legibility of p statementents
gem 'awesome_print'

group :development, :test do
  
  # use rspec for tests by default
  gem 'rspec-rails', '~>2.0'

  # use guard to automate testing
  gem 'guard-rspec'

  # replacement for spork
  # gem 'spring'

  # run guard with spring
  gem 'guard-spork'

  gem 'spork-rails', github: 'railstutorial/spork-rails'

  gem 'childprocess'
end

group :test do
  gem 'capybara', '~> 2.1.0'
  gem 'rb-inotify'
  gem 'libnotify'
  gem 'factory_girl_rails'
end

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
