require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #show" do
      get("/users/1").should route_to("users#show", :id => "1")
    end
    
    it "routes to #questions" do
      get("/users/1/questions_index").should route_to("users#questions_index", :id => "1")
    end
    
    it "routes to #answers" do
      get("/users/1/answers_index").should route_to("users#answers_index", :id => "1")
    end
      
    it "routes to #comments" do
      get("/users/1/comments_index").should route_to("users#comments_index", :id => "1")
    end
  end
end
