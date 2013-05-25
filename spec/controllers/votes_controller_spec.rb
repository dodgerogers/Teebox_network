require 'spec_helper'

describe VotesController do
  include Devise::TestHelpers
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @vote = FactoryGirl.attributes_for(:vote, user_id: @user)
    controller.stub!(:current_user).and_return(@user)
  end
end