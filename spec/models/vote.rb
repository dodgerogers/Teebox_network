require "spec_helper"

describe Vote do
  before(:each) do
    @vote = FactoryGirl.create(:vote)
  end
  
  subject { @vote }
  
  it { should respond_to(:user_id) }
  it { should respond_to(:votable_id) }
  it { should respond_to(:votable_type) }
  it { should respond_to(:value) }
  
   describe 'value' do
     before { @vote.value = nil }
     it { should_not be_valid }
   end
   describe "votable_id" do
     before { @vote.votable_id = nil }
     it { should_not be_valid }
   end
   
   describe "user_id" do
     before { @vote.user_id = nil }
      it { should_not be_valid }
    end
    
    describe "votable type" do
       before { @vote.votable_type = nil }
        it { should_not be_valid }
      end
end