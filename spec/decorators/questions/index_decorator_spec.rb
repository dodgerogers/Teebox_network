require "spec_helper"

describe Questions::IndexDecorator do
  before(:each) do
    @decorator = Questions::IndexDecorator.new()
  end
  
  describe "params parameter" do
    it "returns empty hash" do
      @decorator.params.should eq({})
    end
  end
  
  describe "tag_class" do
    it "returns tag as class" do
      tag = create(:tag)
      @decorator.tag_class(tag).should eq("tag")
    end
  end
  
  describe "tab_class" do
    it "returns asphalt as class" do
      tag = create(:tag)
      @decorator.tab_class(tag).should eq("asphalt")
    end
  end
  
  describe "questions scope" do
    
    before(:each) do
      @user1 = create(:user)
      @q1 = create(:question, user: @user1, correct: true, body: "im slicing it now", votes_count: 1) 
      @q2 = create(:question, user: @user1, correct: false, body: "im hooking the ball", votes_count: 10) 
      @q3 = create(:question, user: @user1, correct: false, body: "i have taken up tennis", votes_count: 5)
    end
    
    it "returns latest questions" do
      @decorator.questions.should == [@q1, @q2, @q3] 
    end
    
    it "returns unanswered questions" do
      @decorator.unanswered_questions.should == [@q2, @q3] 
    end
    
    it "returns unanswered questions" do
      @decorator.votes_questions.should == [@q2, @q3, @q1] 
    end
  end
end