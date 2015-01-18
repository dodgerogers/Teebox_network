require "spec_helper"
include UsersHelper
include AnswerHelper
include CommentHelper

describe "Commments" do
  it "creates a new comment on a question" do
    visit root_path
    sign_in_user
    create_and_find_question
    create_comment
  end
  
  it "creates a new comment on an answer" do
    visit root_path
    sign_in_user
    create_and_find_question
    create_answer
    page.should have_selector("div", id: "question-answers")
    within('#question-answers') do
        fill_in "comment[content]", with: "try a grip change"
    end
    within("#question-answers") do
      expect {
        click_button "Create comment"
      }.to change(Comment, :count).by(1)
    end
    #page.should have_content "try a grip change"
  end
  
  it "fails to create comment with invalid params" do
    visit root_path
    sign_in_user
    create_and_find_question
    page.should have_selector("div", class: "comment-textarea")
    fill_in "comment[content]", with: ""
    expect {
      click_button "Create comment"
    }.to_not change(Comment, :count).by(1) 
  end
  
  # it "deletes a comment", js: true do
  #     visit root_path
  #     sign_in_user
  #     create_and_find_question
  #     create_comment
  #     click_link "View 1 comment"
  #     save_and_open_page
  #     page.should have_selector("div", id: "delete-comment")
  #     click_link "delete-comment"
  #     page.should_not have_selector("div", class: "comment")
  #   end
end