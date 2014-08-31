require "spec_helper"

describe CorrectAnswerRepository do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @question = create(:question, user: @user1, correct: false)
    @answer = create(:answer, question_id: @question.id, user: @user2, correct: false)
  end
  
  describe "#toggle" do
    it "should toggle answer and question correct fields when false" do
      CorrectAnswerRepository.toggle({id: @answer.id})
      @answer.reload
      @answer.correct.should eq true
      @answer.question.correct.should eq true
    end
    
    it "should toggle answer and question correct fields when true" do
      user3 = create(:user)
      correct_question = create(:question, user: @user2, correct: true)
      correct_answer = create(:answer, question_id: correct_question.id, user: user3, correct: true)
      
      CorrectAnswerRepository.toggle({id: correct_answer.id})
      correct_answer.reload
      
      correct_answer.correct.should eq false
      correct_answer.question.correct.should eq false
    end
    
    it "returns nil when answer not found" do
     CorrectAnswerRepository.toggle({id: 999}).should eq nil
    end
  end
end