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
  
  describe "retrieve_payload" do
    before(:each) do
      @raw_video_json = {
        "Type"=>"Notification", 
        "MessageId"=>"fa12b8a4-3c7d-5a48-9927-f308e33212ae", 
        "TopicArn"=>"arn:aws:sns:us-east-1:377092858912:Teebox_processing_DEV", 
        "Subject"=>"Amazon Elastic Transcoder has finished transcoding job 1395842307445-2sfq4p.", 
        "Message"=>"{\n  \"state\" : \"COMPLETED\",\n  \"version\" : \"2012-09-25\",\n  \"jobId\" : \"1395783182474-246e34\",\n  \"pipelineId\" : \"1395619455453-yghva8\",\n  \"input\" : {\n    \"key\" : \"uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/IMG_0587.MOV\",\n    \"frameRate\" : \"auto\",\n    \"resolution\" : \"auto\",\n    \"aspectRatio\" : \"auto\",\n    \"interlaced\" : \"auto\",\n    \"container\" : \"auto\"\n  },\n  \"outputKeyPrefix\" : \"uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/\",\n  \"outputs\" : [ {\n    \"id\" : \"1\",\n    \"presetId\" : \"1395783135978-fq7lgp\",\n    \"key\" : \"IMG_0587.mp4\",\n    \"thumbnailPattern\" : \"IMG_0587-{count}\",\n    \"rotate\" : \"auto\",\n    \"status\" : \"Complete\",\n    \"duration\" : 10,\n    \"width\" : 270,\n    \"height\" : 480\n  } ]\n}", 
        "Timestamp"=>"2014-03-26T13:58:39.002Z", 
        "SignatureVersion"=>"1", 
        "Signature"=>"DMrkFc1tZncm/89i+VV+Aq1Lq31BSrfvEShmPQt5e+fzT2AWOn4eTOr4n2nIohk8svIu8eoFJUGY9aIqf4hhFG/YEfQqYTvWuR6ug2Bu1fPIiJPgOtUW2fpQ2XqZL96lZq6YQeFF+Tfd3jurjGytKoqXK1tEBPB8QxLbSINvICmJ5IeUevOVyFeUT5bOBxiTJjQz96wf97b0fV9+eivVwTsiRGjQiN6oty+tzEflpoQ+5++TJf2lu/7FkgoeqVVDJw9U/WZpxvQyDM942En1ab/YAhw0WMKGwWrTiD0bSNZjPRzxECVyh/igFUCd8hADV5cp5m4UZftSwm8sOGAlFw==", 
        "SigningCertURL"=>"https://sns.us-east-1.amazonaws.com/SimpleNotificationService-e372f8ca30337fdb084e8ac449342c77.pem", 
        "UnsubscribeURL"=>"https://sns.us-east-1.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:us-east-1:377092858912:Teebox_processing_DEV:d902b469-b59d-49d1-a990-a27d63598aac"}
    end
  
      it "dispatches notification" do
      Video.retrieve_payload(@raw_video_json)
      @video.screenshot.should eq "https://teebox-network-dev.s3.amazonaws.com/uploads/video/screenshot/73/3-wood-creamed.m4v.jpg"
      @video.file.should eq "http://teebox-network-dev.s3.amazonaws.com/uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v"
    end
  end
    
  describe "get_key" do
    it "extracts the aws key" do
      subject.get_key.should eq "uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v"  
    end 
  end
end