require "spec_helper"

describe ReportsController do

    it "routes to #index" do
      get("/reports").should route_to("reports#index")
    end

    it "routes to #create" do
      post("/reports").should route_to("reports#create")
    end

    it "routes to #destroy" do
      delete("/reports/1").should route_to("reports#destroy", id: "1")
    end
end
