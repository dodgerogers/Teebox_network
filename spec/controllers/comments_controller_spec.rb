require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers
  include AnswerHelper
  before(:each) do
    @user = create(:user)
    @user2 = create(:user)
    sign_in @user
    sign_in @user2
    @commentable = create(:question, id: 1, title: "slicing the ball", body: "the ball cuts")
    controller.stub!(:current_user).and_return(@user)
    controller.stub!(:load_commentable).and_return(@commentable.id)
    @request.env['HTTP_REFERER'] = "http://test.host/questions/#{@commentable.id}"
    stub_model_methods
  end
  
  #describe "POST create" do
  #  describe "with valid params" do
  #    it "creates a new comment" do
  #      expect {
  #        post :create, comment: attributes_for(:comment)
  #      }.to change(Comment, :count).by(1)
  #    end
  #  end
  #end
    
    describe "DELETE destroy" do
      before(:each) do
        @comment = create(:comment)
      end

      it "destroys the requested comment" do
        expect {
          delete :destroy, id: @comment
        }.to change(Comment, :count).by(-1)
      end
    end
    
    describe "POST vote" do
      it "creates vote with valid params" do
        controller.stub!(:load_commentable).and_return(@commentable)
        expect {
          post :vote, id: attributes_for(:comment_vote, user: @user2), value: 1
        }.to change(Vote, :count).by(1)
      end
    end
end
