source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'rubocop', require: false

gem 'rubycritic', require: false

gem 'rails-i18n', '~> 5.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'devise'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # rspec-rails is a testing framework for Rails 3.x, 4.x and 5.0.
  gem 'rspec-rails'
  # factory_girl is a fixtures replacement with a straightforward definition syntax, support for multiple build strategies (saved instances, unsaved instances, attribute hashes, and stubbed objects), and support for multiple factories for the same class (user, admin_user, and so on), including factory inheritance.
  gem 'factory_bot_rails'
  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'faker'
  # Acceptance test framework for web applications
  gem 'capybara'
  
  gem 'spring-commands-rspec'
  gem 'httparty'
  gem 'webmock'
  gem 'vcr'
  gem 'rails-controller-testing'
  
  gem 'capybara-webkit'
  gem 'rspec-json_expectations'
  gem 'json_matchers'
end


group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Avoid repeating yourself, use pry-rails instead of copying the initializer to every rails project. This is a small gem which causes rails console to open pry. It therefore depends on pry.
  gem 'pry-rails'
  # Better error page for Rack apps
  gem 'better_errors'
  # Better error page for Rack apps
  gem 'binding_of_caller'
end

group :test do
  # Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing. http://databasecleaner.github.io
  gem 'database_cleaner'
  # Collection of testing matchers extracted from Shoulda http://matchers.shoulda.io
  gem 'shoulda-matchers'
  # Collection of RSpec/MiniTest matchers and Cucumber steps for testing email in a ruby app using ActionMailer or Pony
  gem 'email_spec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

