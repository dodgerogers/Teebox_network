require "spec_helper"

describe VideoHelper do
  before(:each) do
    @question = create(:question)
    @video = create(:video)
  end
  
  describe "strip_url" do
    it "retrives the key" do
      helper.strip_url("http://www.youtube.com/watch?v=c59tCXiRwBk").should eq "c59tCXiRwBk" 
    end
  end
  
  describe "youtube_url_html5" do
    it "renders video player iframe" do
      helper.youtube_url_html5("http://www.youtube.com/watch?v=c59tCXiRwBk").should eq "<video class=\"sublime\" data-autoresize=\"fit\" data-name=\"c59tCXiRwBk\" data-uid=\"c59tCXiRwBk\" data-youtube-id=\"c59tCXiRwBk\" height=\"374\" preload=\"none\" width=\"748\"><source src=\"c59tCXiRwBk\" /></video>"
    end
  end
  
  describe "sublime_video" do
    it "renders sublime video element" do
      @user = create(:user)
      @video = create(:video, user: @user)
      helper.sublime_video(@video).should eq "<video class=\"sublime\" data-autoresize=\"fit\" data-name=\"#{@video.file}\" data-uid=\"#{@video.id}\" height=\"374\" id=\"video_#{@video.id}\" preload=\"none\" width=\"748\"><source src=\"#{@video.file}\" /></video>"
    end
  end
  
  describe "sublimevideo_rails" do
    it "retrives the token" do
      helper.sublimevideo_rails.should eq "27jd216p"
    end
  end
  
  describe "display video screenshots" do
    describe "display_xl_screenshot" do
      it "with nil screenshot" do
        helper.display_xl_screenshot(@video).should eq "video_screen.png"
      end
    end
    
    describe "display_mini_screenshot" do
      it "displays with nil video" do
        helper.display_mini_screenshot(@question.video).should eq "video_screen_mini.png"
      end
    end
  end
end