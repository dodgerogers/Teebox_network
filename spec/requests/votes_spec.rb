require "spec_helper"
include UsersHelper
include QuestionHelper
include AnswerHelper

describe "Answers votes" do
  it "creates a new answer" do
    visit root_path
    sign_in_user
    create_and_find_question
    create_answer
  end   
  
  it "creates a vote with upvote" do
    visit root_path
    sign_in_user
    create_and_find_question
    create_answer
    page.should have_selector("div", class: "vote-box")
    sign_out
    sign_in_user2
    expect {
      click_link "upvote"
    }.to change(Vote, :count).by(1)
  end
  
  it "creates a vote with downvote" do
    visit root_path
    sign_in_user
    create_and_find_question
    create_answer
    page.should have_selector("div", class: "vote-box")
    sign_out
    sign_in_user2
    expect {
      click_link "downvote"
    }.to change(Vote, :count).by(1)
  end
end