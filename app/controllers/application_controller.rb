class ApplicationController < ActionController::Base
  protect_from_forgery
  
  ENV['S3_BUCKET'] = 'teebox-network'
  ENV['AWS_SECRET_KEY_ID'] = 'VGCeJnocdXKOV4vAXTb497nW8HTXdn606PqCBMR2'
  ENV['AWS_ACCESS_KEY_ID'] = 'AKIAJ37ROJEVQS6AEO4A'
end
