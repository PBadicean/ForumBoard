require 'rails_helper'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit

  config.include WaitForAjax, type: :feature

  config.include AcceptanceMacros, type: :feature

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"]) if Rails.env.test?
  end
end

Dir["#{Rails.root}/app/uploaders/*.rb"].each { |file| require file }
if defined?(CarrierWave)
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?

    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/cache"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end
