require "spec_helper"

describe VideoHelper do
  
  describe "strip_url" do
    it "retrives the key" do
      helper.strip_url("http://www.youtube.com/watch?v=c59tCXiRwBk").should eq "c59tCXiRwBk" 
    end
  end
  
  describe "youtube_url_html5" do
    it "renders video player iframe" do
      helper.youtube_url_html5("http://www.youtube.com/watch?v=c59tCXiRwBk").should eq "<iframe class='youtube-player' type='text/html' width='100%' height='400' src='http://www.youtube.com/embed/c59tCXiRwBk' frameborder='0'></iframe>"
    end
  end
  
  describe "sublime_video" do
    it "renders sublime video element" do
      @video = create(:video)
      helper.sublime_video(@video, @video.id).should eq "<video id='video_#{@video.id}' class='sublime' poster='' width='475px' height='' data-name='#{@video}' data-uid='#{@video}' preload='none' data-autoresize='fit'>
      <source src='#{@video}' /></video>"
    end
  end
  
  describe "sublimevideo_rails" do
    it "retrives the token" do
      helper.sublimevideo_rails.should eq "27jd216p"
    end
  end
  
  describe "video_select" do
    it "renders the correct js" do
      video = create(:video)
      helper.video_select(video).should eq "var form = $('#question_video_id');\n\t  var icon = $('.1_icon');\n\t  var video = $('#1');\n\t  $('.selected').hide();\n\t\t$('.videos').removeClass('shadow');\n\t  form.val(form.val() == 1 ? 0 : 1);  \n\t  form.val() == 1 ? icon.show() : icon.hide();\n\t  form.val() ==  1 ? video.addClass('shadow') : video.removeClass('shadow');"
  	  end
	  end
end