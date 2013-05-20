require "spec_helper"
include UsersHelper

describe "User management" do
  it "should successfully sign in existing user" do
    sign_in_user
  end
end