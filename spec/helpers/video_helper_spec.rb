require "spec_helper"

describe VideoHelper do
  
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
      @video ||= create(:video, user: @user)
      helper.sublime_video(@video).should eq "<video class=\"sublime\" data-autoresize=\"fit\" data-name=\"#{@video.file}\" data-uid=\"#{@video.id}\" height=\"374\" id=\"video_#{@video.id}\" preload=\"none\" width=\"748\"><source src=\"#{@video.file}\" /></video>"
    end
  end
  
  describe "sublimevideo_rails" do
    it "retrives the token" do
      helper.sublimevideo_rails.should eq "27jd216p"
    end
  end
end