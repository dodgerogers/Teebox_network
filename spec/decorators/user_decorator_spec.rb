require "spec_helper"

describe UserDecorator do
  include ActionView::TestCase::Behavior
  before(:each) do
    @user1 = create(:user)
    sign_in @user1
    @decorator = UserDecorator.new(@user1)
    @decorator.stub!(:current_user).and_return(@user1)
    @answer = create(:answer, user: @user1)
    @comment = create(:comment, user: @user1)
    @question = create(:question, user: @user1)
  end
  
  describe "change_picture" do
    it "renders link" do
      @decorator.change_picture.should eq "<a href=\"http://gravatar.com\" target=\"blank\" title=\"Change your profile picture\"><i class=\"icon-cloud-upload\"></i></a>".html_safe
    end
  end  
  
  describe "my_videos" do
    it "renders link to videos " do
      @decorator.my_videos.should eq "<a href=\"/videos\" class=\"default next\">My Videos</a>"
    end
  end
  
  describe "link_helper" do
    it "renders link to objects" do
      @decorator.link_helper("questions", questions_path, @user1.questions).should eq "<a href=\"/questions\" class=\"default next\">View all questions</a>"
    end
  end
  
  describe "questions" do
    it "returns users questions" do
      @decorator.questions_index.should eq(@decorator.questions_index)
    end  
  end
  
  describe "answers" do
    it "returns users answers" do
      @decorator.answers_index.should eq(@decorator.answers_index)
    end
  end
  
  describe "comments" do
    it "returns users comments" do
      @decorator.comments_index.should eq(@decorator.comments_index)
    end
  end
end