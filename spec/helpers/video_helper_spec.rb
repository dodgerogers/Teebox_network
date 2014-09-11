require "spec_helper"

describe VideoHelper do
  before(:each) do
    @user = create(:user)
    @question = create(:question, user_id: @user.id)
    @video = create(:video, user_id: @user.id)
    @question.videos << @video
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
      helper.sublime_video(@video).should eq "<video class=\"sublime\" data-autoresize=\"fit\" data-name=\"#{@video.file}\" data-uid=\"#{@video.id}\" height=\"374\" id=\"video_#{@video.id}\" preload=\"none\" width=\"748\"><source src=\"#{@video.file}\" /></video>"
    end
  end
  
  describe "sublimevideo_rails" do
    it "retrives the token" do
      helper.sublimevideo_rails.should eq "27jd216p"
    end
  end
  
  describe "display_screenshot" do
    describe "xl" do
      it "displays large screenshot" do
        helper.display_screenshot(@video, :xl).should eq "https://teebox-network-dev.s3.amazonaws.com/uploads/video/screenshot/73/3-wood-creamed.m4v.jpg"
      end
    end
    
    describe "mini" do
      it "displays mini screenshot" do
        helper.display_screenshot(@question.videos[0], :mini).should eq "https://teebox-network-dev.s3.amazonaws.com/uploads/video/screenshot/73/3-wood-creamed.m4v.jpg"
      end
    end
    
    describe "nil video" do
      before(:each) do
        @nil_video = create(:video, user_id: @user.id, screenshot: nil)
      end
      
      it "displays xl placeholder image" do
        helper.display_screenshot(@nil_video, :xl).should eq "video_screen_xl.png"
      end
      
      it "displays mini placeholder image" do
        helper.display_screenshot(@nil_video, :mini).should eq "video_screen_mini.png"
      end
    end
  end
  
  describe "persist_selected" do
    it "displays selected class" do
      helper.persist_selected(@question, @video).should eq 'selected_video'
    end
  end
  
  describe "video_processed?" do
    it "shows processed icon when complete" do
      helper.video_processed?(@video).should eq "<a href=\"#\" class=\"processing\" rel=\"tooltip\" title=\"Processing, refresh to update\"><i class=\"icon-gear green icon-spin\"></i></a>"
    end
    
    it "shows failed icon when ERROR" do
      @video2 = create(:video, status: "ERROR")
      helper.video_processed?(@video2).should eq "<a href=\"#\" class=\"processing\" rel=\"tooltip\" title=\"Converting Failed\"><i class=\"icon-exclamation-sign red\"></i></a>"
    end
  end
end