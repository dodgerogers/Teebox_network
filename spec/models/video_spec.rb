require 'spec_helper'
require "json"

describe Video do
  before(:each) do
    @video = create(:video)
  end
  
  subject { @video }
  
  it { should respond_to(:user_id) }
  it { should respond_to(:file) }
  it { should respond_to(:screenshot) }
  it { should respond_to(:job_id) }
  it { should respond_to(:status) }
  it { should have_many(:questions).through(:playlists) }
  it { should have_many(:playlists)}
  it { should belong_to(:user) }
  
  describe 'file' do
     before { subject.file = nil }
     it { should_not be_valid }
   end
   
  describe "user_id" do
    before { subject.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "retrieve_payload success" do
    before(:each) do
      @raw_video_json = {
        "Type"=>"Notification", 
        "MessageId"=>"fa12b8a4-3c7d-5a48-9927-f308e33212ae", 
        "TopicArn"=>"arn:aws:sns:us-east-1:377092858912:Teebox_processing_DEV", 
        "Subject"=>"Amazon Elastic Transcoder has finished transcoding job 1395842307445-2sfq4p.", 
        "Message"=>"{\n  \"state\" : \"COMPLETED\",\n  \"version\" : \"2012-09-25\",\n  \"jobId\" : \"1395783182474-246e34\",\n  \"pipelineId\" : \"1395619455453-yghva8\",\n  \"input\" : {\n    \"key\" : \"uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/IMG_0587.MOV\",\n    \"frameRate\" : \"auto\",\n    \"resolution\" : \"auto\",\n    \"aspectRatio\" : \"auto\",\n    \"interlaced\" : \"auto\",\n    \"container\" : \"auto\"\n  },
        \n  \"outputKeyPrefix\" : \"uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/\",
        \n  \"outputs\" : [ {\n    \"id\" : \"1\",\n    \"presetId\" : \"1395783135978-fq7lgp\",\n    \"key\" : \"IMG_0587.mp4\",\n    \"thumbnailPattern\" : \"IMG_0587-{count}\",\n    \"rotate\" : \"auto\",\n    \"status\" : \"Complete\",\n    \"duration\" : 10,\n    \"width\" : 270,\n    \"height\" : 480\n  } ]\n}", 
      }
    end
  
      it "dispatches notification" do
      Video.retrieve_payload(@raw_video_json)
      @video.reload
      @video.status.should eq "COMPLETED"
      @video.screenshot.should eq "http://teebox-network-dev.s3.amazonaws.com/uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/IMG_0587-00001.jpg"
      @video.file.should eq "http://teebox-network-dev.s3.amazonaws.com/uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/IMG_0587.mp4"
    end
  end
  
  describe "retrieve_payload error" do
    before(:each) do
      @raw_error_json = {
        "Type"=>"Notification", 
        "MessageId"=>"fa12b8a4-3c7d-5a48-9927-f308e33212ae", 
        "TopicArn"=>"arn:aws:sns:us-east-1:377092858912:Teebox_processing_DEV", 
        "Subject"=>"Amazon Elastic Transcoder has finished transcoding job 1395842307445-2sfq4p.", 
        "Message"=>"{\n  \"state\" : \"ERROR\",\n  \"version\" : \"2012-09-25\",\n  \"jobId\" : \"1395783182474-246e34\",\n  \"pipelineId\" : \"1395619455453-yghva8\",\n  \"input\" : {\n    \"key\" : \"uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/IMG_0587.MOV\",\n    \"frameRate\" : \"auto\",\n    \"resolution\" : \"auto\",\n    \"aspectRatio\" : \"auto\",\n    \"interlaced\" : \"auto\",\n    \"container\" : \"auto\"\n  },\n  
        \"outputKeyPrefix\" : \"uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/\",
        \n  \"outputs\" : [ {\n    \"id\" : \"1\",\n    \"presetId\" : \"1395783135978-fq7lgp\",\n    \"key\" : \"IMG_0587.mp4\",\n    \"thumbnailPattern\" : \"IMG_0587-{count}\",\n    \"rotate\" : \"auto\",\n    \"status\" : \"ERROR\",\n    \"duration\" : 10,\n    \"width\" : 270,\n    \"height\" : 480\n  } ]\n}", 
      }
    end
    
    it "saves error status" do
      Video.retrieve_payload(@raw_error_json)
      @video.reload
      @video.status.should eq "ERROR"
    end
  end
    
  describe "get_key" do
    it "extracts the aws key" do
      subject.get_key.should eq "uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v"  
    end 
  end
end