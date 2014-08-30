require "spec_helper"

describe GeneratePointsRepository do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @question = create(:question, user: @user1, correct: false)
    @answer = create(:answer, question_id: @question.id, user: @user2, correct: false)
  end
  
  describe "#generate" do
    it "assigns points for given objects" do
      GeneratePointsRepository.generate({entry: @answer, value: 12}, {entry: @question, value: 5})
      @answer.reload
      @question.reload
      @answer.point.value.should eq 12
      @question.point.value.should eq 5
    end
    
    it "raises Argument Error when not supplied a hash" do
      expect { 
        GeneratePointsRepository.generate("string argument") 
        }.to raise_error(ArgumentError, "args must be a Hash")
    end
    
    it "raises Argument Error when value is not an integer" do
      expect { 
        GeneratePointsRepository.generate({entry: @answer, value: "string"}) 
        }.to raise_error(ArgumentError, "value must be an integer")
    end
  end
end