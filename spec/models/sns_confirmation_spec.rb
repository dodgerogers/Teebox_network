require "spec_helper"

describe SNSConfirmation do
  describe "confirm" do
    before(:each) do
      @topicArn = "arn:aws:sns:us-east-1:377092858912:Teebox_processing_DEV"
      @token = SecureRandom.hex
      Sns = Struct.new(:confirm_subscription)
    end
    
    it "calls confirm_subscription" do
      sns = Sns.new("confirm")
      AWS::SNS::Client.stub(:new).and_return(sns)
      
      sns.should_receive(:confirm_subscription).once
      SNSConfirmation.confirm(@topicArn, @token)
    end
  end
end