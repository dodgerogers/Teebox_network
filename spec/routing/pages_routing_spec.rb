require "spec_helper"

describe PagesController do
  it "routes to #info" do
    get('/how-it-works').should route_to('pages#info')
  end
  
  it "routes to #sitemap" do
    get('/sitemap').should route_to('pages#sitemap')
  end
  
  it "routes to #sitemap.xml" do
    get('/sitemap.xml').should route_to('pages#sitemap', format: "xml")
  end
end