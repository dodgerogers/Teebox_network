require "spec_helper"

describe QuestionHelper do
  include Devise::TestHelpers
  before(:each) do
    @user1 = create(:user)
    @user1.confirm!
    sign_in @user1
    @question = create(:question, user: @user1)
  end
  
  describe "display_results" do
    it "returns 1 tagged question found" do
      helper.stub!(:params).and_return(true)
      helper.stub!(:total_entries).and_return(:size)
      helper.display_results([@question].paginate, "tag").should include('1 Question found')
    end
  end
  
  describe 'has_videos?(question)' do
    it 'returns green icon when question has videos' do
      video = create(:video, user: @user1)
      @question.videos << video
      helper.has_videos?(@question).should include('green')
    end
    
    it 'returns standard icon when question has videos' do
      @question.videos = []
      helper.has_videos?(@question).should include('0')
    end
  end
end