require 'spec_helper'

describe QuestionsController do
  include Devise::TestHelpers
  include AnswerHelper
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @user2.confirm!
    @user1.confirm!
    sign_in @user1
    sign_in @user2
    @question = create(:question, user: @user1)
    controller.stub!(:current_user).and_return(@user1)
    stub_model_methods
    Vote.any_instance.stub(:sum_votes).and_return(true)
    Vote.any_instance.stub(:user_reputation).and_return(true)
    @request.env['HTTP_REFERER'] = "/questions/#{@question}/"
  end

  describe "GET show" do
    it "assigns a new decorator as @decorator" do
      @decorator = @question
      get :show, id: @decorator
      assigns(:decorator).should eq(@decorator)
    end
    
    it "renders the show template" do
      get :show, id: @question
      response.should render_template :show
    end
  end
  
  describe "GET index" do
    it "renders index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET new" do
    it "assigns a new question as @question" do
      get :new
      assigns(:question).should be_a_new(Question)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "saved a new question to db" do
        expect {
          post :create, question: attributes_for(:question), user: @user1
        }.to change(Question, :count).by(1)
      end

      it "assigns a newly created question as @question" do
        post :create, question: attributes_for(:question), user: @user1
        assigns(:question).should be_a(Question)
        assigns(:question).should be_persisted
      end

      it "redirects to the created question" do
        post :create, question: attributes_for(:question), user: @user1
        response.should redirect_to(Question.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved question as @question" do
        Question.any_instance.stub(:save).and_return(false)
        post :create, question: attributes_for(:question), user: @user1
        assigns(:question).should be_a_new(Question)
      end

      it "re-renders the 'new' template" do
        Question.any_instance.stub(:save).and_return(false)
        post :create, question: attributes_for(:question), user: @user1
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @question = create(:question, user: @user1, title: "now im hooking it!", body: "ball is going to the left")
    end
    
    it "assigns the requested question as @question" do
      put :update, id: @question, question: attributes_for(:question)
      assigns(:question).should eq(@question)
    end
    
    describe "with valid params" do
      it "updates the requested question" do
        put :update, id: @question, question: attributes_for(:question, title: "Shanking now, great!"), user: @user1
        @question.reload
        @question.title.should eq("Shanking now, great!")
      end

      it "redirects to the post" do
        put :update, id: @question, question: attributes_for(:question, title: "Shanking now, great!"), user: @user1
        @question.reload
        response.should redirect_to @question
      end
    end

    describe "with invalid params" do
      it "doesn not change @question attributes" do
        put :update, id: @question, question: attributes_for(:question, title: ""), user: @user1
        @question.reload
        @question.title.should_not eq("")
      end

      #it "re-renders the 'edit' template" do
      #  put :update, id: @question, post: FactoryGirl.attributes_for(:post)
      #  response.should redirect_to posts_url
      #end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @question = create(:question, user: @user1)
    end
    
    it "destroys the requested question" do
      expect {
        delete :destroy, id: @question
      }.to change(Question, :count).by(-1)
    end

    it "redirects to the questions list" do
      delete :destroy, id: @question
      response.should redirect_to root_path
    end
  end
  
  describe "POST vote" do
    it "creates vote with valid params" do
      #Question.stub(:find).and_return(@question)
      expect {
        post :vote, id: @question, value: 1, vote: attributes_for(:question_vote, user_id: @user2)
        #post :vote, id: @question, vote: attributes_for(:vote, user: @user1, value: 1, votable_type: "Question")
      }.to change(Vote, :count).by(1)
    end
    
    it "fails with invalid params" do
      #Question.stub(:find).and_return(@question)
      expect {
        post :vote, id: @question, value: nil, vote: attributes_for(:question_vote, user_id: @user2)
        #post :vote, id: @question, vote: attributes_for(:vote, user: @user1, value: nil, votable_type: "Question")
      }.to_not change(Vote, :count).by(1)
    end
  end
end
