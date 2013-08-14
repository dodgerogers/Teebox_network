require "spec_helper"

describe Devise::RegistrationsController do
  it "routes to #create" do
    post("/users").should route_to("registrations#create")
  end
  
  it "routes to registrations #cancel" do
    get('/users/cancel').should route_to("registrations#cancel")
  end
    
  it "routes to #new" do
    get('/users/sign_up').should route_to("registrations#new")
  end
  
  it "routes to #edit" do
    get('/users/edit').should route_to("registrations#edit")
  end
  
  it "routes to #update" do
    put("/users").should route_to('registrations#update')
  end
  
  it "routes to #destroy" do
    delete('/users').should route_to('registrations#destroy')
  end
end