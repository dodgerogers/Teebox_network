require "spec_helper"

describe PointsController do
  before(:each) do
    @user = create(:user)
    @user.confirm!
    sign_in @user
    controller.stub(:current_user).and_return(@user)
  end
  
  describe "GET index" do
    it "renders index template" do
      get :index, id: @user.id
      response.should render_template :index
    end
  end
end