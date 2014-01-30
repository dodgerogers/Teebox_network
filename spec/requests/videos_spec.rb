require "spec_helper"
include UsersHelper


describe "Videos" do
  before(:each) do
    @file = "#{Rails.root}/spec/fixtures/files/edited_driver_swing.m4v"
  end
  
  it "creates video record" do
    visit root_path
    sign_in_user
    visit videos_path
    within("form.direct-upload") do
      attach_file("file", @file)
    end
    click_link "OK"
    # The custom upload button hides the form field, which causes issues with jQuery fileupload
  end
  
  it "deletes video", js: true do
    visit root_path
    sign_in_user
  end
end