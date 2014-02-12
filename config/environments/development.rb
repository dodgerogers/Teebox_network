TeeboxNetwork::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb
  
  #rotate 3 log files, limit to 1mb each
  config.logger = Logger.new(Rails.root.join("log",Rails.env + ".log"),3,1*1024*1024)

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = false # displays our error pages in development
  config.action_controller.perform_caching = false

  # Mailer settings default to mailcatcher
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtpout.secureserver.net",
    domain: "secureserver.net",
    port: 80,
    user_name: CONFIG[:email_username],
    password: CONFIG[:email_password],
    authentication: "plain",
    enable_starttls_auto: true 
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  
  config.after_initialize do
    Bullet.enable = true
    Bullet.rails_logger = true
  end
end
