require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @question = FactoryGirl.create(:question)
    @comment = FactoryGirl.attributes_for(:comment, user_id: @user, question_id: @question)
    controller.stub!(:current_user).and_return(@user)
  end

end
