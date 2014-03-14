require "spec_helper"
include VideoHelper

describe Questions::ShowDecorator do
  before(:each) do
    @user = create(:user)
    @user.confirm!
    sign_in @user
    @video = create(:video, user: @user)
    @question = create(:question, user: @user)
    @question.videos << @video
    @decorator = Questions::ShowDecorator.new(@question)
    @tag = create(:tag, name: "shank")
    @decorator.tags << @tag
  end
  
  describe "question_tags" do
    it "maps the tags as links" do
      @decorator.question_tags.should eq "<a href=\"/tagged/#{@tag.name}\">#{@tag.name}</a>"
     end
   end
   
   describe "related_questions" do
    it "maps array of similarly titled questions" do
      @question2 = create(:question, user: @user, title: "slicing ball with driver")
      @decorator.related_questions.should eq [@question2]
    end
  end 
end