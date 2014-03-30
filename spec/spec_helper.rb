require 'simplecov'
SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require "rake"
require "shoulda/matchers"
require "capybara/rspec"
require "capybara/webkit/matchers"
Capybara.javascript_driver = :webkit

#==== rspec spec --tag ~speed:slow => to avoid slow javascript tests

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Reduce IO during tests
Rails.logger.level = 4

RSpec.configure do |config|
  
  #Stub out the mailers, enable them when needed.
  config.before(:each) do
    QuestionMailer.any_instance.stub(:new_question_email)
    User.any_instance.stub(:send_on_create_confirmation_instructions)
  end
    
  #factory girl helpers :create(:object) & build(:object)
  config.include FactoryGirl::Syntax::Methods
  
  #Disable observers by default
  ActiveRecord::Base.observers.disable :all

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.include Devise::TestHelpers, type: :controller
  
  config.use_transactional_examples = false
  
  config.include Capybara::DSL

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  
  config.before type: :helper do
    DatabaseCleaner.strategy = :truncation
  end
  
  config.after type: :helper  do
    DatabaseCleaner.strategy = :transaction
  end
  
  config.before(:each) do
    DatabaseCleaner.strategy = (example.metadata[:js] ? :truncation : :transaction)
    DatabaseCleaner.start
  end
  
  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  config.before(:all) { DeferredGarbageCollection.start }
  config.after(:all) { DeferredGarbageCollection.reconsider }
  config.include(Capybara::Webkit::RspecMatchers, type: :feature)
end
