require "spec_helper"

describe AnswerHelper do
  before(:each) do
    @answer = create(:answer)
  end
  
  describe "toggle_correct" do
    it "toggles correct attribute" do
      @answer.toggle_correct(:correct)
      @answer.correct.should eq true
    end
  end
end