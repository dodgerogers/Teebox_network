require "spec_helper"

describe QuestionHelper do
  include Devise::TestHelpers
  before(:each) do
    @user1 = create(:user)
    @user1.confirm!
    sign_in @user1
    @video = create(:video, user_id: @user1.id)
    @question = create(:question, user: @user1, video_id: @video.id)
  end
  
  describe "display_results" do
    it "returns 1 tagged question found" do
      helper.stub!(:params).and_return(true)
      helper.stub!(:total_entires).and_return(:size)
      #paginate questions for total_entries method
      helper.display_results([@question].paginate, "tag").should eq "<div id=\"params\"><h2 class=\"zero-margin\">tag</h2><div>1 Question found</div></div>"
    end
  end
  
  describe "display_video" do
    it "renders default image when no video present" do
      @question.video = nil
      helper.display_video(@question).should eq "<a href=\"/questions/1-slicing-the-ball\"><img alt=\"Video_screen\" src=\"/assets/video_screen.jpg\" /></a>"
    end
    
    it "renders default image when video present but no screenshot" do
      helper.display_video(@question).should eq "<a href=\"/questions/1-slicing-the-ball\"><img alt=\"Video_screen\" src=\"/assets/video_screen.jpg\" /></a>"
    end
    
    it "renders screenshot when video present" do
      #set the screenshots here
    end
  end
end