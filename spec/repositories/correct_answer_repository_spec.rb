require "spec_helper"

describe CorrectAnswerRepository do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @question = create(:question, user: @user1, correct: false)
    @answer = create(:answer, question_id: @question.id, user: @user2, correct: false)
  end
  
  describe "#toggle" do
    it "should toggle answer and question correct fields" do
      CorrectAnswerRepository.toggle({id: @answer.id})
      @answer.reload
      @answer.correct.should eq true
      @answer.question.correct.should eq true
    end
    
    it "returns nil when answer not found" do
     CorrectAnswerRepository.toggle({id: 999}).should eq nil
    end
  end
end