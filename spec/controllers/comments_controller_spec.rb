require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @question = FactoryGirl.create(:question)
    @comment = FactoryGirl.create(:comment)
    controller.stub!(:current_user).and_return(@user)
  end
    
    describe "DELETE destroy" do
      before(:each) do
        @answer = FactoryGirl.create(:comment)
      end

      it "destroys the requested answer" do
        expect {
          delete :destroy, id: @comment
        }.to change(Comment, :count).by(-1)
      end
    end
end
