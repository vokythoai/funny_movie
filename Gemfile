source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.5"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.6'
  gem 'pry', '~> 0.14.1'
  gem 'guard', '~> 2.18'
  gem 'rspec', '~> 3.11'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.1'
  gem 'factory_bot', '~> 6.2'
  gem 'database_cleaner', '~> 2.0', '>= 2.0.1'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3'
  gem 'bullet'
  gem 'rails-controller-testing'
  gem 'cucumber-rails'
  gem 'capybara', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'shoulda-matchers', '~> 5.1'
  gem 'chromedriver-helper'
end

gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'haml-rails', '~> 2.0', '>= 2.0.1'
gem 'bootstrap-sass', '~> 3.4', '>= 3.4.1'
gem 'annotate', '~> 3.2'
gem 'simple_command', '~> 0.1.0'
gem 'carrierwave', '~> 2.2', '>= 2.2.2'
gem 'carrierwave-base64', '~> 2.10'
gem 'kaminari', '~> 1.2', '>= 1.2.2'
gem 'simplecov', '~> 0.21.2'
gem 'net-http'
gem 'bootstrap-kaminari-views', '~> 0.0.5'
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'
gem 'jquery-rails', '~> 4.4'
gem 'redis-namespace', '~> 1.8', '>= 1.8.2'
gem 'redis-rails', '~> 5.0', '>= 5.0.2'
gem 'sidekiq', '~> 6.4', '>= 6.4.1'
