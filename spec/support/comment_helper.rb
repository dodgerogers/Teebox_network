require "spec_helper"

module CommentHelper
  def create_comment
    click_link "Add comment"
    page.should have_selector("div", id: "comment-textarea")
    fill_in "comment-textarea", with: "You need to strengthen your grip"
    expect {
      click_button "Create comment"
    }.to change(Comment, :count).by(1) 
    page.should have_content "You need to strengthen your grip"
  end
end