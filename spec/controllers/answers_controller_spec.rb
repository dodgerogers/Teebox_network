require "spec_helper"

describe AnswersController do
  include Devise::TestHelpers
  include AnswerHelper
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    sign_in @user1
    sign_in @user2
    @answer = create(:answer, user: @user1)
    @vote = attributes_for(:vote, votable_id: @answer, user_id: @user2)
    controller.stub!(:current_user).and_return(@user1)
    stub_model_methods 
    @request.env['HTTP_REFERER'] = "http://test.host/questions/"
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new answer" do
        expect {
          post :create, answer: attributes_for(:answer)
        }.to change(Answer, :count).by(1)
      end

      it "assigns a newly created question as @question" do
        post :create, answer: attributes_for(:answer)
        assigns(:answer).should be_a(Answer)
        assigns(:answer).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved question as @question" do
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:save).and_return(false)
        post :create, answer: attributes_for(:answer)
        assigns(:answer).should be_a_new(Answer)
      end
    end
  end
  
  describe "PUT update" do
    before(:each) do
      @answer = create(:answer, body: "weaken your grip")
    end
    
    it "assigns the requested question as @answer" do
      put :update, id: @answer, answer: attributes_for(:answer)
      assigns(:answer).should eq(@answer)
    end
    
    describe "with valid params" do
      it "updates the requested answer" do
        put :update, id: @answer, answer: attributes_for(:answer, body: "close your stance")
        @answer.reload
        @answer.body.should eq("close your stance")
      end

      it "redirects to the post" do
        put :update, id: @answer, answer: attributes_for(:answer, body: "close your stance")
        @answer.reload
        response.should redirect_to :back
      end
    end

    describe "with invalid params" do
      it "doesn not change @answer attributes" do
        put :update, id: @answer, answer: attributes_for(:answer, body: ""), format: "js"
        @answer.reload
        @answer.body.should_not eq("")
      end
    end
    
    describe "an answer as correct" do
      it "successfully updates" do
        put :correct, id: @answer, answer: @answer, format: "js"
        @answer.reload
        @answer.correct.should eq(true)
      end
    end
  end
  
  describe "DELETE destroy" do
    before(:each) do
      @answer = create(:answer)
    end
    
    it "destroys the requested answer" do
      expect {
        delete :destroy, id: @answer
      }.to change(Answer, :count).by(-1)
    end
  end
  
  describe "POST vote" do
    it "creates vote" do
      expect {
        post :vote, id: @vote, value: 1
      }.to change(Vote, :count).by(1)
    end
  end
end