require "spec_helper"

describe AnswersController do
  include Devise::TestHelpers
  include AnswerHelper
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @user1.confirm!
    @user2.confirm!
    sign_in @user1
    sign_in @user2
    @question = create(:question, user: @user2)
    @answer = create(:answer, user: @user1, question_id: @question.id)
    @vote = attributes_for(:vote, votable_id: @answer.id, user_id: @user2, votable_type: "Answer", value: 1, points: 5)
    controller.stub!(:current_user).and_return(@user1)
    @request.env['HTTP_REFERER'] = "http://test.host/questions/"
  end
  
  subject { @answer }
  
  describe "GET show" do
    it "assigns a new answer as @answer" do
      get :show, question_id: @question.id, id: @answer
      assigns(:answer).should eq(@answer)
    end
    
    it "renders the show template" do
      get :show, question_id: @question.id, id: @answer
      response.should render_template :show
    end
  end
  
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new answer" do
        @question = create(:question, user: @user1)
        expect {
          post :create, answer: attributes_for(:answer, question_id: @question.id)
        }.to change(Answer, :count).by(1)
      end
      
      it "creates a new answer point" do
        @question = create(:question, user: @user1)
        expect {
          post :create, answer: attributes_for(:answer, question_id: @question.id)
        }.to change(Point, :count).by(1)
      end

      it "assigns a newly created answer as @answer" do
        @question = create(:question, user: @user1)
        post :create, answer: attributes_for(:answer, question_id: @question.id)
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
    it "assigns the requested question as @answer" do
      @answer = create(:answer, body: "weaken your grip", question_id: @question.id)
      put :update, id: @answer, answer: attributes_for(:answer)
      assigns(:answer).should eq(@answer)
    end
    
    describe "with valid params" do
      it "updates the requested answer" do
        @answer = create(:answer, body: "weaken your grip", question_id: @question.id)
        put :update, id: @answer, answer: attributes_for(:answer, body: "close your stance")
        @answer.reload
        @answer.body.should eq("close your stance")
      end

      it "redirects to the post" do
        @answer = create(:answer, body: "weaken your grip", question_id: @question.id)
        put :update, id: @answer, answer: attributes_for(:answer, body: "close your stance")
        @answer.reload
        response.should redirect_to :back
      end
    end

    describe "with invalid params" do
      it "doesn not change @answer attributes" do
        @answer = create(:answer, body: "weaken your grip", question_id: @question.id)
        put :update, id: @answer, answer: attributes_for(:answer, body: ""), format: "js"
        @answer.reload
        @answer.body.should_not eq("")
      end
    end
    
    describe "correct" do
      it "successfully updates answer and question reputation" do
        PointRepository.stub(:generate).and_return(true)
        put :correct, id: @answer, answer: @answer, format: "js"
        @answer.reload
        response.status.should eq 200
      end
    end
  end
  
  describe "POST vote" do
    it "creates vote with valid params" do
      controller.stub(:current_user).and_return(@user2)
      expect {
        post :vote, id: @answer.id, value: 1
      }.to change(Vote, :count).by(1)
    end
    
    it "fails with invalid params" do
      controller.stub(:current_user).and_return(@user2)
      expect {
        post :vote, id: @answer.id, value: nil
      }.to_not change(Vote, :count).by(1)
    end
  end
  
  describe "Destroy Answer" do
    it "destroys the requested answer" do
      @question = create(:question, user: @user1)
      @answer = create(:answer, user: @user2, question_id: @question.id)
      expect {
        delete :destroy, id: @answer
      }.to change(Answer, :count).by(-1)
    end
  end
end