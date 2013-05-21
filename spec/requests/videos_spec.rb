require "spec_helper"
include UsersHelper

describe "Videos" do
  it "create without login to prompt login" do
    sign_in_user
    click_link "Ask a Question"
    page.should have_content "Step 1: Upload a Video"
  end
end