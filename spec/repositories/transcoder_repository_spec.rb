require "spec_helper"

describe TranscoderRepository do
  before(:each) do
    @user = create(:user)
    @video = create(:video, user_id: @user.id)
  end
  
  describe "#initialize" do
    it "raises Argument Error when not supplied a video object" do
      expect { 
        TranscoderRepository.new("string argument") 
        }.to raise_error(ArgumentError, "TranscoderRepository error: not a valid video object")
    end
  end
end