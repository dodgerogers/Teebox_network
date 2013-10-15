require "spec_helper"

describe AnswerHelper do
  before(:each) do
    @user1 = create(:user)
    @question = create(:question, user_id: @user1.id)
    @answer = create(:answer, question_id: @question.id)
  end
  
  describe "toggle_correct" do
    it "toggles correct attribute" do
      @answer.toggle_correct(:correct)
      @answer.correct.should eq true
    end
  end
end