require "spec_helper"
include UsersHelper

describe "Videos" do
  it "create without login to prompt login" do
    visit root_path
    sign_in_user
    click_link "Ask a Question"
    page.should have_content "Step 1: Upload a Video"
    #add create video here here
  end
  
  it "deletes video" do
    visit root_path
    sign_in_user
    click_link "Ask a Question"
    #create video then destroy
  end
end