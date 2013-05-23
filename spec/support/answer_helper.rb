require "spec_helper"

module AnswerHelper
  def create_and_find_question
    visit root_path
    click_link "Ask a Question"
    page.should have_content "Step 1: Upload a Video"
    click_link "Step 2"
    page.should have_content "Ask a question"
    fill_in "Title", with: "Ball starting too far left"
    fill_in "Body", with: "my clubface is closed..."
    expect {
      click_button "Save"
    }.to change(Question, :count).by(1) 
    page.should have_content "Question Created"
    page.should have_content "Add your answer"
  end
  
  def create_answer
    click_link "Add your answer"
    page.should have_selector("div", id: "new_answer")
    fill_in "answer_body", with: "You need to shift your weight better"
    expect {
      click_button "Save Answer"
    }.to change(Answer, :count).by(1) 
    page.should have_content "You need to shift your weight better"
  end
end