require "spec_helper"

module QuestionHelper
  def click_on_question
    click_link "Ask a Question"
    page.should have_content "Step 1: Upload a Video"
    click_link "Step 2"
    page.should have_content "Ask your question"
  end
end