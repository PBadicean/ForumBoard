Rails.application.configure do

  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.read_encrypted_secrets = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new


  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.action_mailer.default_url_options = { host: '185.143.172.213' }

  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.smtp_settings = { address: '185.143.172.213', port: 25 }

  config.action_cable.allowed_request_origins = ["http://185.143.172.213"]
end
