require "spec_helper"

describe PagesController do
  it "routes to #info" do
    get('/pages/info').should route_to('pages#info')
  end
end