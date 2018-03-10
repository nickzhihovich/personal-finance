source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'carrierwave', '~> 1.0'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pry-byebug'
gem 'puma', '~> 3.7'
gem 'reek'
gem 'rubocop', require: false
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'slim'
gem 'turbolinks', '~> 5'

gem 'jbuilder', '~> 2.5'
gem 'rails', '~> 5.1.5'
gem 'ransack'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 3.2'
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'dotenv-rails'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'rspec-rails', '~> 3.7'
end

group :development do
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
