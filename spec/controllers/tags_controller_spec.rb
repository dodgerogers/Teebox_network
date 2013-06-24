require 'spec_helper'

describe TagsController do
  include Devise::TestHelpers
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @tag = FactoryGirl.attributes_for(:tag)
    controller.stub!(:current_user).and_return(@user)
  end
  
  describe "GET index" do
    it "renders index template" do
      get :index
      response.should render_template("index")
    end
  end

  describe "GET new" do
    it "assigns a new tag as @tag" do
      get :new
      assigns(:tag).should be_a_new(Tag)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new tag" do
        expect {
          post :create, tag: @tag
        }.to change(Tag, :count).by(1)
      end

      it "assigns a newly created question as @tag" do
        post :create, tag: @tag
        assigns(:tag).should be_a(Tag)
        assigns(:tag).should be_persisted
      end

      it "redirects to the created tag" do
        post :create, tag: @tag
        response.should redirect_to(Tag.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tag as @tag" do
        # Trigger the behavior that occurs when invalid params are submitted
        Tag.any_instance.stub(:save).and_return(false)
        post :create, tag: @tag
        assigns(:tag).should be_a_new(Tag)
      end

      it "re-renders the 'index' template" do
        Tag.any_instance.stub(:save).and_return(false)
        post :create, tag: @tag
        response.should redirect_to tags_path
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @tag = FactoryGirl.create(:tag, name: "qweqwe ew qew qew")
    end
    
    it "assigns the requested tag as @tag" do
      put :update, id: @tag, tag: FactoryGirl.attributes_for(:tag)
      assigns(:tag).should eq(@tag)
    end
    
    describe "with valid params" do
      it "updates the requested tag" do
        put :update, id: @tag, tag: FactoryGirl.attributes_for(:tag, name: "top")
        @tag.reload
        @tag.name.should eq("top")
      end

      it "redirects to the tag index" do
        put :update, id: @tag, tag: FactoryGirl.attributes_for(:tag, name: "top")
        @tag.reload
        response.should redirect_to(@tag)
      end
    end

    describe "with invalid params" do
      it "doesn not change @question attributes" do
        put :update, id: @tag, tag: FactoryGirl.attributes_for(:tag, name: "")
        @tag.reload
        @tag.name.should_not eq("")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @tag = FactoryGirl.create(:tag)
    end
    
    it "destroys the requested question" do
      expect {
        delete :destroy, id: @tag
      }.to change(Tag, :count).by(-1)
    end

    it "redirects to the questions list" do
      delete :destroy, id: @tag
      response.should redirect_to tags_path
    end
  end
end
