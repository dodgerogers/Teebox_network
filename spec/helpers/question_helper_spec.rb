require "spec_helper"

describe QuestionHelper do
  include Devise::TestHelpers
  before(:each) do
    @user1 = create(:user)
    @user1.confirm!
    sign_in @user1
    @video = create(:video, user_id: @user1.id)
    @question = create(:question, user: @user1)
  end
  
  describe "display_results" do
    it "returns 1 tagged question found" do
      helper.stub!(:params).and_return(true)
      helper.stub!(:total_entires).and_return(:size)
      #paginate questions for total_entries method
      helper.display_results([@question].paginate, "tag").should eq "<div id=\"params\"><h2 class=\"zero-margin\">tag</h2><div>1 Question found</div></div>"
    end
  end
end