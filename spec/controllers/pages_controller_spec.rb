require "spec_helper"

describe PagesController do
  describe "GET info" do
    it "renders info template" do
      get :info
      response.should render_template :info
    end
  end
end