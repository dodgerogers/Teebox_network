require "spec_helper"

describe "Questions" do
  it "GET questions" do
    get questions_path
    response.status.should be(200)
  end
  
  it "creates a new question" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Ask a Question"
    page.should have_content "You need to sign in or sign up before continuing"
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Sign in"
    page.should have_content "Signed in successfully"
    page.should have_content "Step 1: Upload a Video"
    click_link "Step 2"
    page.should have_content "Ask a question"
    fill_in "Title", with: "Ball starting too far left"
    fill_in "Body", with: "my clubface is closed..."
    
    expect {
      click_button "Save"
    }.to change(Question, :count).by(1)
    
    page.should have_content "Question Created"
    save_and_open_page
  end
    
end
    