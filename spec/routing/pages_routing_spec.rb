require "spec_helper"

describe PagesController do
  it "routes to #info" do
    get('/how_it_works').should route_to('pages#info')
  end
end