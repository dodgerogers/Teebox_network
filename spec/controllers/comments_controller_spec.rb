require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers
  include AnswerHelper
  before(:each) do
    @user = create(:user)
    @user2 = create(:user)
    @user.confirm!
    @user2.confirm!
    sign_in @user
    sign_in @user2
    @commentable = create(:question, id: 1, title: "slicing the ball", body: "the ball cuts")
    @answer = create(:comment, user: @user)
    @vote = attributes_for(:vote, votable_id: @comment, user_id: @user2)
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
        #@activity = create(:activity, trackable_id: @comment.id, trackable_type: "Comment", owner_id: @comment.user.id)
      end

      it "destroys the requested comment" do
        expect {
          delete :destroy, id: @comment
        }.to change(Comment, :count).by(-1)
      end
    end
    
    describe "POST vote" do
      it "creates vote with valid params" do
        Comment.stub!(:find).and_return(@commentable)
        expect {
          post :vote, id: @vote, value: 1
        }.to change(Vote, :count).by(1)
      end
    end
end
