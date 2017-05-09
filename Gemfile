# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'pg', '~> 0.18'
gem 'rails', '~> 5.0.2'

gem 'coffee-rails', '~> 4.2'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'select2-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

gem 'activeadmin'
gem 'aws-sdk', '~> 2.3.0'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'bootstrap-will_paginate', '~> 1.0'
gem 'cancancan', '~> 1.16'
gem 'devise', '~> 4.2', '>= 4.2.1'
gem 'paperclip', '~> 5.0.0'
gem 'will_paginate', '~> 3.1', '>= 3.1.5'

group :development, :test do
  gem 'brakeman', require: false
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails', '~> 0.3.5'
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
end

group :development do
  gem 'bullet'
  gem 'listen', '~> 3.0.5'
  gem 'ruby-growl'
  gem 'ruby_gntp'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '~> 3.1'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
