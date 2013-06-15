require 'spec_helper'

describe Question do
  before(:each) do
    @question = FactoryGirl.create(:question)
  end
  
  subject {@question}
  
  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:video_id) }
  it { should respond_to(:youtube_url) }
  it { should respond_to(:user_id) }
  it { should respond_to(:votes_count)}
  it { should respond_to(:answers_count)}
  it { should respond_to(:points)}
  it { should respond_to(:correct)}
  
   describe 'title' do
     before { @question.title = nil }
     it { should_not be_valid }
   end
   describe "body" do
     before { @question.body = nil }
     it { should_not be_valid }
   end
   
   describe "user_id" do
     before { @question.user_id = nil }
      it { should_not be_valid }
    end
    
    describe "video_id" do
       before { @question.video_id = nil }
        it { should_not be_valid }
    end
end