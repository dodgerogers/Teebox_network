require "spec_helper"

describe ActivitiesController do
  include Devise::TestHelpers
  before(:each) do
    @user1 = create(:user)
    @user1.confirm!
    sign_in @user1
    controller.stub!(:current_user).and_return(@user1)
  end

  describe "GET index" do
    it "renders index template" do
      get :index
      response.should render_template :index
    end
  end
end