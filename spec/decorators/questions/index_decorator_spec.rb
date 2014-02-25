require "spec_helper"
include QuestionHelper

describe Questions::IndexDecorator do
  before(:each) do
    @decorator = Questions::IndexDecorator.new()
    @tag = create(:tag, name: "shank")
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
  
  describe "tagged_questions" do
    it "params[:tag]" do
      @question = create(:question)
      @question.tags << @tag
      @decorator.params[:tag] = "shank"
      @decorator.tagged_questions.should eq [@question]
    end
  end
  
  describe "search" do
    it "params[:search]" do
      @question = create(:question)
      @decorator.params[:search] = "slicing"
      @decorator.search.should eq [@question]
    end
  end
end