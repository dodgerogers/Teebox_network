require "spec_helper"
include UsersHelper

describe "User management" do
  it "should successfully sign in existing user" do
    visit root_path
    sign_in_user
  end
  
  it "fails to login in user with invalid credentials" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Login"
    fill_in "Username", with: user.username
    fill_in "Password", with: ""
    click_button "Sign in"
    page.should have_content "Invalid email or password"
  end
  
  it "successfully creates new user" do
    visit root_path
    click_link "Sign up"
    page.should have_content "Sign up"
    fill_in "Email", with: "Test@hotmail.com"
    fill_in "Username", with: "tester"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    expect {
      click_button "Sign up"
    }.to change(User, :count).by(1)
  end
  
  it "fails to create new user with invalid params" do
    visit root_path
    click_link "Sign up"
    page.should have_content "Sign up"
    fill_in "Email", with: "Test@hotmail.com"
    fill_in "Username", with: "tester"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: ""
    expect {
      click_button "Sign up"
    }.to_not change(User, :count).by(1)
  end
end