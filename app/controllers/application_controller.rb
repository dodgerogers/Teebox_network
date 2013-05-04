class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  #move soon
  S3_BUCKET = 'teebox-network'
  AWS_SECRET_KEY_ID = 'VGCeJnocdXKOV4vAXTb497nW8HTXdn606PqCBMR2'
  AWS_ACCESS_KEY_ID = 'AKIAJ37ROJEVQS6AEO4A'
  
end
