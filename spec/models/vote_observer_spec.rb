require "spec_helper"

describe VoteObserver do
  before(:each) do 
    @answer = FactoryGirl.create(:answer)
    @user = FactoryGirl.create(:user)
    @vote = FactoryGirl.create(:vote)
  end
  subject { @vote }
  
end