source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'dotenv-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem "capybara-webkit"
  gem 'capybara-email'
end

group :development do
  gem 'letter_opener'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-unicorn', require: false
end

group :test do
  gem 'launchy'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
  gem 'json_spec'
end

gem 'unicorn'
gem 'active_model_serializers', '~> 0.9.3'
gem 'skim'
gem 'sprockets', '>= 3.7.0'
gem 'slim-rails'
gem 'devise'
gem 'jquery-rails'
gem 'carrierwave'
gem 'remotipart'
gem "cocoon"
gem 'gon'
gem 'responders'
gem 'cancancan'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'doorkeeper'
gem 'oj'
gem 'oj_mimic_json'
gem 'sidekiq'
gem 'whenever'
gem 'mysql2'
gem 'thinking-sphinx', '3.3.0'
gem "redis", "~> 3.0"
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
