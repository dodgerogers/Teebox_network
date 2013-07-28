require "spec_helper"
include UsersHelper
include AnswerHelper

describe "Answers" do
  it "creates a new answer" do
    visit root_path
    sign_in_user
    create_and_find_question
    create_answer
  end   
    
  it "deletes an answer" do
    visit root_path
    sign_in_user
    create_and_find_question
    create_answer
    page.should have_selector("div", id: "delete-answer")
    expect {
      click_link "delete-answer"
    }.to change(Answer, :count).by(-1)
  end
  
  it "fails to create answer with invalid params" do
    visit root_path
    sign_in_user
    create_and_find_question
    click_link "Add your answer"
    page.should have_selector("div", id: "new_answer")
    fill_in "answer_body", with: ""
    
    expect {
      click_button "Save Answer"
    }.to_not change(Answer, :count).by(1)
  end
  
  it "edits the answer successfullly with valid params" do
    visit root_path
     sign_in_user
     question = FactoryGirl.create(:question)
     visit questions_path
     visit question_path(question)
     answer = FactoryGirl.create(:answer)
     visit question_path(question)
     page.should have_content answer.body
     page.should have_selector("a", id: "edit-answer")
   end
   
  it "updates the correct column" do
    visit root_path
    sign_in_user 
    create_and_find_question
    create_answer
    page.should have_selector('div', class: "default-tick")
    click_link "tick"
    page.should have_selector("div", class: "green-tick")
  end
end