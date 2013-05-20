require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    controller.stub!(:current_user).and_return(@user)
  end
  
  describe "GET show" do
    it "assigns a new user as @user" do
      get :show, id: @user
      assigns(:user).should eq(@user)
    end
    
    it "renders the show template" do
      get :show, id: @user
      response.should render_template :show
    end
  end
end
