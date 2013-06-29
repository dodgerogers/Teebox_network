require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers
  include AnswerHelper
  before(:each) do
    @user = create(:user)
    @user2 = create(:user)
    sign_in @user
    sign_in @user2
    @commentable = create(:question, user: @user)
    @comment = create(:comment, user: @user)
    @vote = attributes_for(:vote, user: @user2)
    controller.stub!(:current_user).and_return(@user)
    controller.stub!(:load_commentable).and_return(@commentable)
    @request.env['HTTP_REFERER'] = "http://test.host/questions/"
    stub_model_methods
  end
  
  #describe "POST create" do
  #  describe "with valid params" do
  #    it "creates a new comment" do
  #      expect {
  #        post :create, comment: @comment, user: @user
  #      }.to change(Comment, :count).by(1)
  #    end

  #    it "assigns a newly created comment as @comment" do
  #      post :create, comment: [attributes_for(:comment), user: @user]
  #      assigns(:comment).should be_a(Comment)
  #      assigns(:comment).should be_persisted
  #    end
  #  end

  #  describe "with invalid params" do
  #    it "assigns a newly created but unsaved comment as @comment" do
  #      Comment.any_instance.stub(:save).and_return(false)
  #      post :create, comment: attributes_for(:comment)
  #      assigns(:comment).should be_a_new(Comment)
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
        expect {
          post :vote, id: @vote, value: 1
        }.to change(Vote, :count).by(1)
      end
    end
end
