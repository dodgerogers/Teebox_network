require "spec_helper"

describe AnswersController do
  include Devise::TestHelpers
  before(:each) do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    sign_in @user1
    sign_in @user2
    @answer = FactoryGirl.attributes_for(:answer, user_id: @user1)
    @vote = FactoryGirl.attributes_for(:vote, votable_id: @answer, user_id: @user2)
    controller.stub!(:current_user).and_return(@user1)
    Vote.any_instance.stub(:sum_votes).and_return(true)
    Vote.any_instance.stub(:user_reputation).and_return(true)
    @request.env['HTTP_REFERER'] = "http://test.host/questions/"
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new answer" do
        expect {
          post :create, user_id: @user1, answer: @answer
        }.to change(Answer, :count).by(1)
      end

      it "assigns a newly created question as @question" do
        post :create, answer: @answer
        assigns(:answer).should be_a(Answer)
        assigns(:answer).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved question as @question" do
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:save).and_return(false)
        post :create, answer: @answer
        assigns(:answer).should be_a_new(Answer)
      end
    end
  end
  
  describe "PUT update" do
    before(:each) do
      @answer = FactoryGirl.create(:answer, body: "weaken your grip")
    end
    
    it "assigns the requested question as @answer" do
      put :update, id: @answer, answer: FactoryGirl.attributes_for(:answer)
      assigns(:answer).should eq(@answer)
    end
    
    describe "with valid params" do
      it "updates the requested answer" do
        put :update, id: @answer, answer: FactoryGirl.attributes_for(:answer, body: "close your stance")
        @answer.reload
        @answer.body.should eq("close your stance")
      end

      it "redirects to the post" do
        put :update, id: @answer, answer: FactoryGirl.attributes_for(:answer, body: "close your stance")
        @answer.reload
        response.should redirect_to :back
      end
    end

    describe "with invalid params" do
      it "doesn not change @answer attributes" do
        put :update, id: @answer, answer: FactoryGirl.attributes_for(:answer, body: ""), format: "js"
        @answer.reload
        @answer.body.should_not eq("")
      end
    end
  end
  
  describe "DELETE destroy" do
    before(:each) do
      @answer = FactoryGirl.create(:answer)
    end
    
    it "destroys the requested answer" do
      expect {
        delete :destroy, id: @answer
      }.to change(Answer, :count).by(-1)
    end
  end
  
  describe "it updates the correct column" do
  end
  
  describe "POST vote" do
    it "creates vote" do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @answer = FactoryGirl.attributes_for(:answer, user_id: @user1)
      expect {
        post :vote, id: @vote, value: 1
      }.to change(Vote, :count).by(1)
    end
  end
end