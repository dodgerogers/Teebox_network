require "spec_helper"

describe VideoHelper do
  before(:each) do
    @user = create(:user)
    @question = create(:question, user_id: @user.id)
    @video = create(:video, user_id: @user.id)
    @question.videos << @video
  end
  
  describe 'format_name' do
    it 'returns name when present' do
      helper.format_name(@video).should eq @video.name
    end
    
    it 'returns truncated name when option specified' do
      helper.format_name(@video, truncate: true).should include @video.name
    end
    
    it 'returns formatted filename when name is nil' do
      video_without_name = create :video, name: nil
      helper.format_name(video_without_name).should eq video_without_name.formatted_filename
    end
  end
  
  describe "display_video_meta_info" do
    it 'includes location and name' do
      html = helper.display_video_meta_info(@video)
      
      html.should include @video.location
      html.should include '00:10'
    end
    
    it 'does not include name or location when nil' do
      location = @video.location
      @video.should_receive(:location).and_return(nil)
      @video.should_receive(:duration).and_return(nil)
      html = helper.display_video_meta_info(@video)
      
      html.should_not include location
      html.should_not include "00:10"
    end
  end
  
  describe "strip_url" do
    it "retrives the key from youtube video" do
      helper.strip_url("http://www.youtube.com/watch?v=c59tCXiRwBk").should eq "c59tCXiRwBk" 
    end
  end
  
  describe "youtube_url_html5" do
    it "renders video player iframe" do
      html = helper.youtube_url_html5("http://www.youtube.com/watch?v=c59tCXiRwBk")
      html.should include "c59tCXiRwBk"
      html.should include "sublime"
    end
  end
  
  describe "sublime_video" do
    it "renders sublime video element" do
      html = helper.sublime_video(@video)
      html.should include @video.file
      html.should include 'sublime'
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
    it "shows processed message when complete" do
      helper.video_processed?(@video).should include "Processing, refresh to update"
    end
    
    it "shows failed message when error" do
      @video2 = create(:video, status: "ERROR")
      helper.video_processed?(@video2).should include "Converting Failed"
    end
  end
end