require "spec_helper"
include UsersHelper
include AnswerHelper
include CommentHelper

describe "Commments" do
  it "creates a new comment" do
    sign_in_user
    create_and_find_question
    create_comment
  end
  
  it "deletes a comment" do
     sign_in_user
      create_and_find_question
      create_comment
      page.should have_selector("div", id: "delete-comment")
      expect {
        click_link "delete-comment"
      }.to change(Comment, :count).by(-1)
    end
end