require "spec_helper"

describe QuestionHelper do
  include Devise::TestHelpers
  before(:each) do
    @user1 = create(:user)
    @user1.confirm!
    sign_in @user1
  end
  
  describe "display_results" do
    it "returns 1 tagged question found" do
      helper.stub!(:params).and_return(true)
      helper.stub!(:total_entires).and_return(:size)
      @questions = create(:question, user: @user1)
      #paginate questions for total_entries method
      helper.display_results([@questions].paginate, "tag").should eq "<h2 class=\"zero-margin universe\">tag</h2><div>1 Question found</div>"
    end
  end
end