require "spec_helper"
include QuestionHelper

describe Questions::IndexDecorator do
  before(:each) do
    @decorator = Questions::IndexDecorator.new()
  end
  
  describe "params parameter" do
    it "returns empty hash" do
      @decorator.params.should eq({})
    end
  end
  
  describe "questions scope" do
    it "returns latest questions" do
      create_questions # QuestionHelper
      @decorator.newest_questions.should == [@q3, @q2, @q1] 
    end
  end
end