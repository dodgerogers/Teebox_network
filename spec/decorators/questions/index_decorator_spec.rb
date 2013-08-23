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
  
  describe "current_page" do
    it "returns correct path" do
      @decorator.current_page.should eq("http://test.host/")
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
    it "returns array of questions" do
      @user1 = create(:user)
      q1 = create(:question, user: @user1, correct: true, body: "im slicing it now") 
      q2 = create(:question, user: @user1, correct: false, body: "im hooking the ball") 
      q3 = create(:question, user: @user1, correct: false, body: "i have taken up tennis") 
      @decorator.questions.should == [q1, q2, q3] 
    end
  end
end