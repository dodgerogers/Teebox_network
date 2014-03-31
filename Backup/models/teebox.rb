require 'yaml'

# Since Backup usually operates outside of the app typically, we have to read in the BACKUP variables
# so we can re-use the yml variables
# remember to gem install backup, not supposed to reside in Gemfile
rails_env = ENV['RAILS_ENV'] || 'development'
BACKUP = YAML.load(File.read(File.expand_path('../../../config/application.yml', __FILE__)))
BACKUP.merge!(BACKUP.fetch(rails_env, {}))
#BACKUP.symbolize_keys!
# encoding: utf-8

##
# Backup Generated: teebox
# Once BACKUPured, you can run the backup with the following command in a cron task:
#
# $ backup perform -t teebox -c "#{Rails.root}/Backup/BACKUP.rb"
# 
#
Backup::Model.new(:teebox, 'Backup the Teebox DB') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name               = BACKUP["db_name"]
    db.username           = BACKUP["db_username"]
    db.password           = BACKUP["db_password"]
    db.host               = "localhost"
    db.port               = 5432
  end
  
  ## OpenSSL encryption
  # openssl aes-256-cbc -d -base64 -in teebox.tar.enc -out teebox.tar
  # will prompt for password
  # encrypt_with OpenSSL do |encryption|
  #     encryption.password = 'my_password'
  #     encryption.base64   = true
  #     encryption.salt     = true
  #   end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  store_with S3 do |s3|
    s3.access_key_id     = BACKUP["aws_access_key_id"]
    s3.secret_access_key = BACKUP["aws_secret_key_id"]
    s3.region            = "us-east-1"
    s3.bucket            = BACKUP["s3_bucket"]
    s3.path              = "/backups/"
    s3.keep              = 4
  end
  
  # Gzip [Compressor]
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the Wiki for other delivery options.
  # https://github.com/meskyanichi/backup/wiki/Notifiers
  #
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true
    mail.from                 = BACKUP["email_username"]
    mail.to                   = BACKUP["admin_email"]
    mail.address              = "smtpout.secureserver.net"
    mail.port                 = 80
    mail.domain               = "secureserver.net"
    mail.user_name            = BACKUP["email_username"]
    mail.password             = BACKUP["email_password"]
    mail.authentication       = "plain"
    mail.encryption           = :starttls
  end
end
