require "spec_helper"

describe Vote do
  before(:each) do
    @user2 = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)
    @answer = FactoryGirl.create(:answer, user_id: @user)
    @vote = Vote.create(user_id: @user2.id, value: 1, points: 5, votable_id: @answer.id, votable_type: "Answer")
  end
  
  subject { @vote }
  
  it { should respond_to(:user_id) }
  it { should respond_to(:votable_id) }
  it { should respond_to(:votable_type) }
  it { should respond_to(:value) }
  it { should respond_to(:points) }
  
   describe 'value' do
     before { @vote.value = nil }
     it { should_not be_valid }
   end
   
   describe "user_id" do
      before { @vote.user_id = nil }
       it { should_not be_valid }
     end
     
   describe "votable_id" do
     before { @vote.votable_id = nil }
     it { should_not be_valid }
   end
    
   describe "votable type" do
      before { @vote.votable_type = nil }
      it { should_not be_valid }
   end
  
   describe "vote value" do
      before { @vote.value = 5 }
      it { should_not be_valid }
   end
end