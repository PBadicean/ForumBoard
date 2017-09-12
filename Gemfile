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

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'launchy'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end

gem 'skim'
gem 'sprockets', '>= 3.7.0'
gem 'slim-rails'
gem 'rails-controller-testing'
gem 'devise'
gem "capybara-webkit"
gem 'jquery-rails'
gem 'database_cleaner'
gem 'carrierwave'
gem 'remotipart'
gem "cocoon"
gem 'gon'
gem 'responders'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
