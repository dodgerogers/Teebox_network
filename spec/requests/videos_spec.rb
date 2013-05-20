require "spec_helper"
include UsersHelper

describe "Videos" do
  it "create without login to prompt login" do
    visit questions_path
    click_link "Ask a Question"
    page.should have_content "You need to sign in or sign up before continuing"
  end
end