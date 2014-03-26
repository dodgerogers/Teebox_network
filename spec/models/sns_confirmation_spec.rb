require "spec_helper"

describe SNSConfirmation do
  describe "confirm" do
    before(:each) do
      @topicArn = "arn:aws:sns:us-east-1:377092858912:Teebox_processing_DEV"
      @token = "2336412f37fb687f5d51e6e241d638b05d6998069e62e12c7d85c9e62480f14a064375566fa834069118ba9ea5984697253eb1ce9f1dfb08d048d2bbfd2e0f0d1c2af54aca89c5cbe8c20ee115a346180953440972f8d9766b062437206cb6a34473c577cc179f6069ab0c6d4212e7953a5908de4a611a8e1fdeca0706f11e66"
    end
    
    it "does something" do
      SNSConfirmation.confirm(@topicArn, @token).should be_a_kind_of(Excon::Response)
    end
  end
end