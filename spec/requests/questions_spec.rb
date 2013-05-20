require "spec_helper"
include UsersHelper
include Questionhelper

describe "Questions" do
  it "GET questions" do
    get questions_path
    response.status.should be(200)
  end
  
  it "creates a new question" do
    sign_in_user
    click_on_question
    fill_in "Title", with: "Ball starting too far left"
    fill_in "Body", with: "my clubface is closed..."
    expect {
      click_button "Save"
    }.to change(Question, :count).by(1) 
    page.should have_content "Question Created"
  end
  
  it "fails to create question with invalid params" do
    sign_in_user
    click_on_question
    fill_in "Title", with: ""
    fill_in "Body", with: "my clubface is closed"
    click_button "Save"
    page.should have_content "1 error prohibited this post from being saved:"
    page.should have_content "Title can't be blank"
    current_path.should eq questions_path
  end 
  
  it "edits the question successfullly with valid params" do
  end
end
    