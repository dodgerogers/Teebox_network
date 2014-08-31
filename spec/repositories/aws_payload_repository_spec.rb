require "spec_helper"

describe AwsVideoPayloadRepository do
  before(:each) do
    @video = create(:video)
  end
  
  describe "retrieve_payload" do
    describe "success when state COMPLETED" do
      it "creates attributes hash" do
        attributes_hash = AwsVideoPayloadRepository.retrieve_payload(JSON.parse(success_json_response, symbolize_names: true))
        
        attributes_hash.should be_a(Hash)
        attributes_hash.length.should eq 4
        
        attributes_hash[:job_id].should eq "1395783182474-246e34"
        attributes_hash[:status].should eq "COMPLETED"
        attributes_hash[:file].should eq "http://teebox-network-dev.s3.amazonaws.com/uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/IMG_0587.mp4"
        attributes_hash[:screenshot].should eq "http://teebox-network-dev.s3.amazonaws.com/uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/IMG_0587-00001.jpg"
      end
    end
  
    describe "failure" do
      it "saves error status" do
        attributes_hash = AwsVideoPayloadRepository.retrieve_payload(JSON.parse(err_json_response, symbolize_names: true))
        
        attributes_hash.should be_a(Hash)
        attributes_hash.length.should eq 2
        
        attributes_hash[:job_id].should eq "1395783182474-246e34"
        attributes_hash[:status].should eq "ERROR"
      end
    end
  end
  
  
  def success_json_response
    '{
        "Type": "Notification",
        "MessageId": "fa12b8a4-3c7d-5a48-9927-f308e33212ae",
        "TopicArn": "arn:aws:sns:us-east-1:377092858912:Teebox_processing_DEV",
        "Subject": "Amazon Elastic Transcoder has finished transcoding job 1395842307445-2sfq4p.",
        "Message": {
            "state": "COMPLETED",
            "version": "2012-09-25",
            "jobId": "1395783182474-246e34",
            "pipelineId": "1395619455453-yghva8",
            "input": {
                "key": "uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/IMG_0587.MOV",
                "frameRate": "auto",
                "resolution": "auto",
                "aspectRatio": "auto",
                "interlaced": "auto",
                "container": "auto"
            },
            "outputKeyPrefix": "uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/",
            "outputs": [
                {
                    "id": "1",
                    "presetId": "1395783135978-fq7lgp",
                    "key": "IMG_0587.mp4",
                    "thumbnailPattern": "IMG_0587-{count}",
                    "rotate": "auto",
                    "status": "Complete",
                    "duration": 10,
                    "width": 270,
                    "height": 480
                }
            ]
        }
    }'
  end
  
  def err_json_response
    '{
        "Type" : "Notification", 
        "MessageId" : "fa12b8a4-3c7d-5a48-9927-f308e33212ae", 
        "TopicArn" : "arn:aws:sns:us-east-1:377092858912:Teebox_processing_DEV", 
        "Subject" : "AmazoElastic Transcoder has finished transcoding job 1395842307445-2sfq4p.", 
        "Message" : {
            "state" : "ERROR", 
            "version" : "2012-09-25", 
            "jobId" : "1395783182474-246e34", 
            "pipelineId" : "1395619455453-yghva8", 
            "input" : { 
              "key" : "uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/IMG_0587.MOV",   
              "frameRate" : "auto",   
              "resolution" : "auto",   
              "aspectRatio" : "auto",   
              "interlaced" : "auto",   
              "container" : "auto" 
            }, 
            "outputKeyPrefix" : "uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/",
            "outputs" : [ 
                {
                  "id" : "1",
                   "presetId" : "1395783135978-fq7lgp",   
                   "key" : "IMG_0587.mp4",   
                   "thumbnailPattern" : "IMG_0587-{count}",   
                   "rotate" : "auto",   
                   "status" : "ERROR",   
                   "duration" : 10,   
                   "width" : 270,   
                   "height" : 480 
                } 
              ]
          } 
      }'
  end
end