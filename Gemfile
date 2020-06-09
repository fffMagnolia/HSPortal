source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '6.0.2.1'
gem 'bcrypt', '3.1.7'
gem 'puma', '~> 4.1'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'email_validator', '2.0.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'will_paginate', '3.1.7'
gem 'faker', '2.11.0'
gem 'sass-rails', '6.0.0'
gem 'bootstrap4-datetime-picker-rails', '0.3.1'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Reduces boot times through caching; required in config/boot.rb

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '1.4'
  gem 'warning'
  gem 'letter_opener', '1.7.0'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'minitest', '5.14.0'
  gem 'rails-controller-testing', '1.0.4'
end

group :production do
  gem 'pg', '1.2.3'
  # herokuで詳細なログが見れる
  gem 'rails_12factor'
end
