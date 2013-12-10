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
    @comment = create(:comment, user_id: @user.id, commentable_id: @commentable.id)
    @vote = attributes_for(:comment_vote, votable_id: @comment.id, user_id: @user2)
    controller.stub!(:current_user).and_return(@user)
    @request.env['HTTP_REFERER'] = "http://test.host/questions/#{@commentable.id}"
  end
  
  subject { @comment }
  
  describe "POST create" do
     describe "with valid params" do
      it "creates a new comment" do
        Comment.stub!(:find).and_return(@commentable)
        expect {
          post :create, comment: attributes_for(:comment), commentable: @commentable.id
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        Comment.stub!(:find).and_return(@commentable)
        post :create, comment: attributes_for(:comment), commentable: @commentable.id
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end
      
      it "redirects to the commentable question" do
        Comment.stub!(:find).and_return(@commentable)
        post :create, comment: attributes_for(:comment), commentable: @commentable.id
        response.should redirect_to("http://test.host/questions/#{@commentable.id}")
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        Comment.stub!(:find).and_return(@commentable)
        Comment.any_instance.stub(:save).and_return(false)
        post :create,comment: attributes_for(:comment), commentable: @commentable.id
        assigns(:comment).should be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        Comment.stub!(:find).and_return(@commentable)
        Comment.any_instance.stub(:save).and_return(false)
        post :create, comment: attributes_for(:comment), commentable: @commentable.id
        response.should redirect_to("http://test.host/questions/#{@commentable.id}")
      end
    end
  end
    
  describe "DELETE destroy" do
    before(:each) do
      @comment = create(:comment, commentable_id: @commentable.id)
  end

    it "destroys the requested comment" do
      expect {
        delete :destroy, id: @comment
      }.to change(Comment, :count).by(-1)
    end
  end
    
  describe "POST vote" do
    it "creates vote with valid params" do
      controller.stub(:current_user).and_return(@user2)
      expect {
        post :vote, id: @comment.id, value: 1
      }.to change(Vote, :count).by(1)
    end
    
    it "fails with invalid params" do
      controller.stub(:current_user).and_return(@user2)
      expect {
        post :vote, id: @comment.id, value: nil
      }.to_not change(Vote, :count).by(1)
    end
  end
end
