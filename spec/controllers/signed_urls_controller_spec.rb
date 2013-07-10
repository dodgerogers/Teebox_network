require "spec_helper"

describe SignedUrlsController do
  before(:each) do
    @user1 = create(:user)
    sign_in @user1 
    @controller = SignedUrlsController.new
    @policy = @controller.instance_eval {s3_upload_policy_document}
    end
    
    describe "s3_upload_policy_document" do
      it "returns policy" do
        @controller.instance_eval { s3_upload_policy_document.should }.should eq @policy
      end
    end
  end

  