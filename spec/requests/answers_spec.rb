require "spec_helper"
include UsersHelper
include AnswerHelper

describe "Answers" do
  it "creates a new answer" do
    sign_in_user
    create_and_find_question
    click_link "Add your answer"
    page.should have_selector("div", id: "new_answer")
    fill_in "answer_body", with: "You need to shift your weight better"
    expect {
      click_button "Save Answer"
    }.to change(Answer, :count).by(1) 
    page.should have_content "You need to shift your weight better"
  end
end