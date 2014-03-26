require "spec_helper"

describe MetaHelper do
  include Devise::TestHelpers
  before(:each) do
    @user1 = create(:user)
    @user1.confirm!
    sign_in @user1
    @video = create(:video, user_id: @user1.id)
    @question = create(:question, user: @user1)
    @question.videos << @video
  end
  
  describe "meta_builder" do
    it "accepts block and formats string" do
      helper.meta_builder(:title, "Latest") { "Latest " + META['title'] }.should eq "Latest #{META['title']}"
    end
  end
  
  describe "meta_title" do
    it "with no params returns META" do
      helper.meta_title.should eq META["title"]
    end
    
    it "with valid params returns string" do
      helper.meta_title("Latest").should eq "Latest | #{META["title"]}"
    end
  end
  
  describe "meta_keywords" do
    it "with no params returns META" do
      helper.meta_keywords.should eq META["keywords"]
    end
    
    it "with valid params returns string" do
      helper.meta_keywords("golf").should eq "golf, #{META["keywords"]}"
    end
  end
  
  describe "meta_description" do
    it "with no params returns META description" do
      helper.meta_description.should eq META["description"]
    end
    
    it "with valid params returns string" do
      helper.meta_description("This is how we do it").should eq "This is how we do it. #{META['description']}"
    end
  end
  
  describe "meta_image" do
    it "displays url with video" do
      helper.meta_image(@question.videos).should eq "https://teebox-network-dev.s3.amazonaws.com/uploads/video/screenshot/73/3-wood-creamed.m4v.jpg"
    end
  end
  
  describe "social_meta_info" do
    it "displays meta content tags" do
      helper.social_meta_info(@question).should eq "<meta content=\"summary\" name=\"twitter:card\"></meta><meta content=\"@teebox_network\" name=\"twitter:site\"></meta><meta content=\"@teebox_network\" name=\"twitter:creator\"></meta><meta content=\"http://test.host\" name=\"twitter:url\"></meta><meta content=\"http://test.host\" name=\"twitter:domain\"></meta><meta content=\"#{@question.title}\" name=\"twitter:title\"></meta><meta content=\"#{@question.body}\" name=\"twitter:description\"></meta><meta content=\"#{@video.screenshot}\" name=\"twitter:image\"></meta><meta content=\"#{@video.screenshot}\" property=\"og:image\"></meta>"
    end
  end
  
  describe "social_statistics" do
    before(:each) do
        @stat1 = create(:social)
        @stat2 = create(:social)
      end
      
    it "fetches last stat record" do
      helper.social_statistics.should eq @stat2
    end
  end
end