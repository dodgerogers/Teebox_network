require "spec_helper"
include UsersHelper

describe "Videos" do
  it "creates video record" do
    visit root_path
    sign_in_user
    click_link "Ask"
    page.should have_content "Step 1: Upload a Video"
    #add create video here here
  end
  
  it "deletes video" do
    visit root_path
    sign_in_user
    @video = create(:video)
    #need to create a video here
  end
end