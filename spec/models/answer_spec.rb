require "spec_helper"

describe Answer do
  before(:each) do
    @answer = FactoryGirl.create(:answer)
  end
  
  subject { @answer }
  
  it { should respond_to(:user_id) }
  it { should respond_to(:question_id) }
  it { should respond_to(:body) }
  it { should respond_to(:correct)}
  it { should respond_to(:votes_count)}
    
  describe 'body' do
     before { @answer.body = nil }
     it { should_not be_valid }
   end
   
   describe "user_id" do
     before { @answer.user_id = nil }
      it { should_not be_valid }
    end
    
  describe "question_id" do
     before { @answer.question_id = nil }
      it { should_not be_valid }
    end
    
end