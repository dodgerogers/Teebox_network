require "spec_helper"

describe Devise::RegistrationsController do
  include Devise::TestHelpers
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
end