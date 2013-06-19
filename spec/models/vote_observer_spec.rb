require "spec_helper"

describe VoteObserver do
  before(:each) do 
    @answer = FactoryGirl.create(:answer)
    @vote = FactoryGirl.create(:vote)
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