require "spec_helper"

describe AnswerHelper do
  include Devise::TestHelpers
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @user1.confirm!
    @user2.confirm!
    sign_in @user1
    sign_in @user2
    @question = create(:question, user: @user1)
    @answer = create(:answer, user: @user1, question_id: @question.id, correct: true)
    @false_answer = create(:answer, user: @user2, question_id: @question.id, correct: false)
  end
  
  describe "correct_answer_bg(answer)" do
    it "returns bg class if true" do
      helper.correct_answer_bg(@answer).should eq "correct-answer-bg"
    end
  end
  
  describe "correct_answer?(answer)" do
    it "returns green tick when true" do
      helper.correct_answer?(@answer).should eq "green-tick"
    end 
    
    it "returns grey tick when false" do
      helper.correct_answer?(@false_answer).should eq "default-tick"
    end
  end
end