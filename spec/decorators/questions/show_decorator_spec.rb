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
      #raw model.tags.map(&:attributes).map {|tag| link_to tag["name"], tagged_path(tag["name"]), class: "tag" }.join(" ")
     end
   end
   
  describe "sublime_player" do
    it "renders player video element" do
      @decorator.sublime_video(@question.video.file, @question.video.id).should eq "<video id='video_#{@question.video.id}' class='sublime' poster='' width='475px' height='' data-name='http://teebox-network.s3.amazonaws.com/uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v' data-uid='http://teebox-network.s3.amazonaws.com/uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v' preload='none' data-autoresize='fit'>\n      <source src='http://teebox-network.s3.amazonaws.com/uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v' /></video>".html_safe
    end
  end
  
  describe "youtube_player" do
    it "renders correct youtube element" do
      @decorator.youtube_player.should eq "<iframe class='youtube-player' type='text/html' width='100%' height='400' src='http://www.youtube.com/embed/' frameborder='0'></iframe>".html_safe
    end
  end
end