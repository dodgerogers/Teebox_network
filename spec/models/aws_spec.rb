require "spec_helper"

describe Aws do
  before(:each) do
    @pic = File.open("#{Rails.root}/spec/fixtures/files/seven_iron.jpeg")
    @video = create(:video, screenshot: @pic)
    ScreenshotUploader.any_instance.stub(:store!).and_return(@pic)
  end
  
  subject { Aws }
  
  describe "get_screenshots" do
    it "maps an array of formatted videos screenshots attributes" do
      subject.get_screenshots.should eq ["uploads/video/screenshot/1/seven_iron.jpeg", "uploads/video/screenshot/1/mini_seven_iron.jpeg"]
    end
  end
  
  describe "get_videos" do
    it "maps an array of formatted videos file attributes" do
      subject.get_videos.should eq ["uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v"]
    end
  end
  
  describe "cleanup" do
    it "returns nil array difference" do
    end
    
    it "returns file array difference" do
    end
  end
end