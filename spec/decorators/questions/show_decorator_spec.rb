require "spec_helper"
include VideoHelper

describe Questions::ShowDecorator do
  before(:each) do
    @user = create(:user)
    @user.confirm!
    sign_in @user
    @video = create(:video, user: @user)
    @question = create(:question, video: @video, user: @user)
    @decorator = Questions::ShowDecorator.new(@question)
  end
  
  describe "question_tags" do
    it "maps the tags" do
      @decorator.question_tags.should eq ""
     end
   end
   
   describe "related_questions" do
    it "maps array of similarly titled questions" do
      #model.related_questions
    end
  end 
end