# Load the rails application
require File.expand_path('../application', __FILE__)

#initialize the aws credentials
aws_credentials = File.join(Rails.root, 'config', 'aws_credentials.rb')
load(aws_credentials) if File.exists?(aws_credentials)

# Initialize the rails application
TeeboxNetwork::Application.initialize!
