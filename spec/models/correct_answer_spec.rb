require "spec_helper"

describe CorrectAnswer do
  #move this to a helper as it shares code with answer spec
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @question = create(:question, user: @user1)
    @answer = create(:answer, correct: false, user: @user1, body: "You can still hook the ball with a weak grip", question_id: @question.id)
    @correct = CorrectAnswer.new(@answer)
  end
  
  subject { @correct }
  
  describe "#new" do
    it "takes one parameter and returns a CorrectAnswer object" do
      @correct.should be_an_instance_of CorrectAnswer
    end
  end

  describe "adding reputation" do
    describe "answer_correct?" do
      it "returns false" do
        @correct.answer_correct?(false).should eq false
      end
    end
  
    describe "updating_reputation" do
      it "updates answer reputation" do
      end
    end
  end
end