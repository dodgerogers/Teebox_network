require "spec_helper"

describe AnswersController do

    it "routes to #index" do
      get("/questions/1/answers").should route_to("answers#index", question_id: "1")
    end

    it "routes to #new" do
      get("/questions/1/answers/new").should route_to("answers#new",question_id: "1")
    end

    it "routes to #show" do
      get("/questions/1/answers/1").should route_to("answers#show",question_id: "1", :id => "1")
    end

    it "routes to #create" do
      post("/questions/1/answers").should route_to("answers#create",question_id: "1")
    end
    
    it "routes to #edit" do 
      get("questions/1/answers/1/edit").should route_to('answers#edit', question_id: "1", id: "1")
    end
    
    it "routes to #update" do 
      put("questions/1/answers/1").should route_to('answers#update', question_id: "1", id: "1")
    end

    it "routes to #destroy" do
      delete("/questions/1/answers/1").should route_to("answers#destroy", question_id: "1", :id => "1")
    end
end
