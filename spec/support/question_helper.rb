require "spec_helper"

module QuestionHelper
  def click_on_question
    click_link "Ask"
    page.should have_content "Step 1: Upload Videos"
    click_link "Step 2"
    page.should have_content "Ask your question"
  end
  
  def create_questions
    @user1 = create(:user)
    @q1 = create(:question, user: @user1, correct: true, body: "im slicing it now", votes_count: 1) 
    @q2 = create(:question, user: @user1, correct: false, body: "im hooking the ball", votes_count: 10) 
    @q3 = create(:question, user: @user1, correct: false, body: "i have taken up tennis", votes_count: 5)
  end
end