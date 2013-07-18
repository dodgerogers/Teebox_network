CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key => ENV['AWS_SECRET_KEY_ID'],
    :region => 'us-east-1'
  }
  
  config.fog_directory = ENV['S3_BUCKET']
  config.fog_public = true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  config.enable_processing = true
  if Rails.env.test?
    config.storage = :file 
  else
    config.storage = :fog
  end
end