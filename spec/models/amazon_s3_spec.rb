require "spec_helper"

describe AmazonS3 do
  before(:each) do
    @video = create(:video)
  end
  
  subject { AmazonS3 }
  
  describe "find_videos" do
    it "maps an array of formatted videos files and screenshots" do
      subject.find_videos.should eq ["uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v", "uploads/video/screenshot/73/3-wood-creamed.m4v.jpg"]
    end
  end
  
  describe "cleanup" do
    it "returns nil array difference" do
    end
    
    it "returns file array difference" do
    end
  end
end