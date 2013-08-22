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
    @comment = create(:comment, user_id: @user.id)
    @vote = attributes_for(:vote, votable_id: @comment, user_id: @user2)
    controller.stub!(:current_user).and_return(@user)
    @request.env['HTTP_REFERER'] = "http://test.host/questions/#{@commentable.id}"
    stub_model_methods
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
        response.should redirect_to(@commentable)
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
        post :create,comment: attributes_for(:comment), commentable: @commentable.id
        response.should redirect_to(@commentable)
      end
    end
  end
    
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
      Comment.stub!(:find).and_return(@commentable)
      expect {
        post :vote, id: @vote, value: 1
      }.to change(Vote, :count).by(1)
    end
    
    it "doesn't create a vote with invalid params" do
      Comment.stub(:find).and_return(@commentable)
      expect {
        post :vote, id: @vote, value: nil
      }.to_not change(Vote, :count).by(1)
    end
  end
end
