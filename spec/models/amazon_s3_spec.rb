require "spec_helper"

describe AmazonS3 do
  before(:each) do
    @pic = File.open("#{Rails.root}/spec/fixtures/files/seven_iron.jpeg")
    @video = create(:video, screenshot: @pic)
    ScreenshotUploader.any_instance.stub(:store!).and_return(@pic)
  end
  
  subject { AmazonS3 }
  
  describe "find_videos" do
    it "maps an array of formatted videos files and screenshots" do
      subject.find_videos.should eq ["uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v","uploads/video/screenshot/1/seven_iron.jpeg", "uploads/video/screenshot/1/mini_seven_iron.jpeg"]
    end
  end
  
  describe "cleanup" do
    it "returns nil array difference" do
    end
    
    it "returns file array difference" do
    end
  end
end