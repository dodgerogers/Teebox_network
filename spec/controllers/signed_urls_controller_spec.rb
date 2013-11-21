require "spec_helper"

describe SignedUrlsController do
  before(:each) do
    @user1 = create(:user)
    @user1.confirm!
    sign_in @user1 
    @controller = SignedUrlsController.new
    @policy = @controller.instance_eval {s3_upload_policy_document}
    end
    
  describe "index calls s3_upload_signature" do
    it "should add policy document" do
      #@controller.should_receive(:s3_upload_policy_document).with(@policy)
    end
  end
end

  