require "spec_helper"

describe VoteObserver do
  before(:each) do 
    @user2 = create(:user)
    @user = create(:user)
    @question = create(:question, user: @user2)
    @answer = create(:answer, user: @user, question_id: @question.id)
    @vote = create(:vote, user: @user2, value: 1, votable_id: @answer.id) 
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