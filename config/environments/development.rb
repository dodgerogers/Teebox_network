TeeboxNetwork::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Mailer settings default to mailcatcher
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
   :address => "smtp.gmail.com",
   :port => 587,
   :domain => "gmail.com",
   :user_name => "andrewcmagics@gmail.com",
   :password => "azonic12",
   :authentication => "plain",
   :enable_starttls_auto => true
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


  #AWS
  ENV['S3_BUCKET'] = 'teebox-network'
  ENV['AWS_SECRET_KEY_ID'] = 'VGCeJnocdXKOV4vAXTb497nW8HTXdn606PqCBMR2'
  ENV['AWS_ACCESS_KEY_ID'] = 'AKIAJ37ROJEVQS6AEO4A'
  
  #FFMPEG location
  ENV["FFMPEG_LOCATION"] = "/usr/local/bin/ffmpeg"
  
  #Pusher 
  ENV['PUSHER_APP_ID'] = '50498'
  ENV['PUSHER_KEY'] = '9f2de1d5ad50d4662010'
  ENV['PUSHER_SECRET'] = '012cf02f89cb69d5f365'
end
