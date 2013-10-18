CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id =>  CONFIG[:aws_access_key_id],
    :aws_secret_access_key => CONFIG[:aws_secret_key_id],
    :region => 'us-east-1'
  }
  
  config.fog_directory = CONFIG[:s3_bucket]
  config.fog_public = true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  if Rails.env.test?
    config.storage = :file 
    enable_processing = false
  else
    config.storage = :fog
  end
end