require "spec_helper"

describe PagesController do
  describe "GET info" do
    it "renders info template" do
      get :info
      response.should render_template :info
    end
  end
  
  describe "GET sitemap" do
    it "renders sitemap html template" do
      get :sitemap
      response.should render_template :sitemap
    end
    
    it "renders sitemap xml template" do
      get :sitemap, format: :xml
      response.should render_template :sitemap
    end
  end
end