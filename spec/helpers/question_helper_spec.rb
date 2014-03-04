require "spec_helper"

describe QuestionHelper do
  include Devise::TestHelpers
  before(:each) do
    @user1 = create(:user)
    @user1.confirm!
    sign_in @user1
    @video = create(:video, user_id: @user1.id)
    @question = create(:question, user: @user1)
    @question.videos << @video
  end
  
  describe "display_results" do
    it "returns 1 tagged question found" do
      helper.stub!(:params).and_return(true)
      helper.stub!(:total_entires).and_return(:size)
      #paginate questions for total_entries method
      helper.display_results([@question].paginate, "tag").should eq "<div id=\"params\"><h2 class=\"zero-margin\">tag</h2><div>1 Question found</div></div>"
    end
  end
  
  describe "social_meta_info" do
    it "displays meta content tags" do
      helper.social_meta_info(@question).should eq "<meta content=\"summary\" name=\"twitter:card\"></meta><meta content=\"@teebox_network\" name=\"twitter:site\"></meta><meta content=\"@teebox_network\" name=\"twitter:creator\"></meta><meta content=\"#{@question.title}\" name=\"twitter:title\"></meta><meta content=\"#{truncate @question.body, length: 200}\" name=\"twitter:description\"></meta><meta content=\"video_screen.png\" name=\"twitter:image\"></meta><meta content=\"video_screen.png\" property=\"og:image\"></meta>"
    end
  end
end