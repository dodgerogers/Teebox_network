require "spec_helper"
include UsersHelper
include QuestionHelper
include AnswerHelper

describe "Questions" do
  it "GET questions" do
    get questions_path
    response.status.should be(200)
  end
  
  it "creates a new question" do
    visit root_path
    sign_in_user
    create_and_find_question
  end
  
  it "fails to create question with invalid params" do
    visit root_path
    sign_in_user
    click_on_question
    fill_in "Title", with: ""
    fill_in "Body", with: "my clubface is closed"
    expect {
      click_button "Save"
    }.to_not change(Question, :count).by(1)
    page.should have_content "2 errors prohibited this post from being saved:"
    current_path.should eq questions_path
  end 
  
  it "edits the question successfullly with valid params" do
    visit root_path
    sign_in_user
    create_and_find_question
    within('.form-area') do
      page.should have_content "Edit"
      click_link "Edit"
    end
    page.should have_content "Edit your question"
    fill_in "question_title", with: "this is a new title"
    click_button "Save"
    expect {
      question.title.should eq "this is a new title"
    }
  end
  
  it "unauthorized edit redirect to home page" do
    visit root_path
    sign_in_user
    @question = create(:question)
    sign_out
    sign_in_standard_user
    visit edit_question_path(@question)
    page.should have_content "You are not authorized to access this page"
  end
end
    