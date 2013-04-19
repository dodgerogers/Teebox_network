CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => 'AKIAJ37ROJEVQS6AEO4A',
    :aws_secret_access_key => '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' ,
    :region => 'us-east-1'
  }
  
  config.fog_directory = "teebox-network"
  config.fog_public = true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end