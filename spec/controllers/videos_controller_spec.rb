require 'spec_helper'

describe VideosController do
  include Devise::TestHelpers
  before(:each) do
    @user = create(:user)
    sign_in @user
    @video = create(:video, user_id: @user)
    controller.stub!(:current_user).and_return(@user)
  end
  
  describe "GET show" do
   it "assigns a new video as @video" do
      @video = create(:video)
      get :show, id: @video
      assigns(:video).should eq(@video)
    end
    
    it "renders the show template" do
      @video = create(:video)
      get :show, id: @video
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
      assigns(:video).should be_a_new(Video)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new video" do
        expect {
          post :create, video: attributes_for(:video), user_id: @user
        }.to change(Video, :count).by(1)
      end

      it "assigns a newly created video as @video" do
        post :create, video: attributes_for(:video), user_id: @user
        assigns(:video).should be_a(Video)
        assigns(:video).should be_persisted
      end

      it "redirects to the video index" do
        post :create, video: attributes_for(:video), user_id: @user
        response.should redirect_to videos_path
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved video as @video" do
        # Trigger the behavior that occurs when invalid params are submitted
        Video.any_instance.stub(:save).and_return(false)
        post :create, video: attributes_for(:video), user_id: @user
        assigns(:video).should be_a_new(Video)
      end

      it "re-renders the 'new' template" do
        Video.any_instance.stub(:save).and_return(false)
        post :create, video: attributes_for(:video), user_id: @user
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @video = FactoryGirl.create(:video)
      Video.any_instance.stub(:delete_key).and_return(@video)
    end
    
    it "destroys the requested video" do
      expect {
        delete :destroy, id: @video
      }.to change(Video, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete :destroy, id: @video
      response.should redirect_to videos_url
    end
  end
end
