require "spec_helper"

module UsersHelper
  def sign_in_user
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Login"
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Sign in"
    page.should have_content "Signed in successfully"
  end
end