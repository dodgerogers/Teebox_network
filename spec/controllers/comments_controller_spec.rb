require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers
  include AnswerHelper
  before(:each) do
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    sign_in @user
    sign_in @user2
    @question = FactoryGirl.create(:question)
    @comment = FactoryGirl.create(:comment)
    @vote = FactoryGirl.attributes_for(:vote, votable_id: @comment, votable_type: "Comment", user_id: @user2)
    controller.stub!(:current_user).and_return(@user)
    controller.stub!(:load_commentable).and_return(@question)
    @request.env['HTTP_REFERER'] = "http://test.host/questions/"
    stub_model_methods
  end
    
    describe "DELETE destroy" do
      before(:each) do
        @answer = FactoryGirl.create(:comment)
      end

      it "destroys the requested comment" do
        expect {
          delete :destroy, id: @comment
        }.to change(Comment, :count).by(-1)
      end
    end
    
    describe "POST vote" do
      it "creates vote with valid params" do
        expect {
          post :vote, id: @vote, value: 1
        }.to change(Vote, :count).by(1)
      end
    end
end
