require 'spec_helper'

describe Video do
  before(:each) do
    @video = FactoryGirl.create(:video)
  end
  
  subject { @video }
  
  it { should respond_to(:user_id) }
  it { should respond_to(:file) }
  it { should respond_to(:screenshot) }
  it { should respond_to(:question_id) }
  
  describe 'content' do
     before { @video.file = nil }
     it { should_not be_valid }
   end
   
   describe "user_id" do
     before { @video.user_id = nil }
      it { should_not be_valid }
    end
    
end