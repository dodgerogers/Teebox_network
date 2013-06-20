require "spec_helper"

describe VoteObserver do
  before(:each) do 
    @user2 = FactoryGirl.create(:user)
    @answer = FactoryGirl.create(:answer, user_id: @user2)
    @user = FactoryGirl.create(:user)
    @vote = Vote.create(user_id: @user.id, value: 1, points: 5, votable_id: @answer.id, votable_type: "Answer")
    @observer = VoteObserver.instance
  end
  
  subject { @observer }
  
  it "should invoke after_create on the observed object" do
    subject.should_receive(:after_create)
    Vote.observers.enable :vote_observer do
    @observer.after_create(@vote)
    end
  end
end