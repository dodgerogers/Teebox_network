require 'spec_helper'

describe Question do
  before(:each) do
    @question = create(:question)
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
  it { should belong_to(:user)}
  it { should have_many(:comments)}
  it { should have_many(:votes)}
  it { should have_many(:answers)}
  it { should have_many(:tags)}
  it { should have_many(:taggings)}
  
   describe 'title' do
     before { @question.title = nil }
     it { should_not be_valid }
   end
   
   describe "long title" do
     before { @question.title = ("a" * 301) }
      it { should_not be_valid }
   end
   
   describe "short title" do
      before { @question.title = ("a" * 9) }
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
    
    describe "Scopes" do
    it "returns a sorted array of unanswered questions" do 
      @user1 = create(:user)
      q1 = create(:question, user: @user1, correct: true, body: "im slicing it now") 
      q2 = create(:question, user: @user1, correct: false, body: "im hooking the ball") 
      q3 = create(:question, user: @user1, correct: false, body: "i have taken up tennis") 
      q4 = @question
      Question.unanswered.should == [q4, q2, q3] 
    end
    
    it "returns a sorted array questions by votes" do 
      @user1 = create(:user)
      q1 = create(:question, user: @user1, correct: true, body: "im slicing it now", votes_count: 1) 
      q2 = create(:question, user: @user1, correct: false, body: "im hooking the ball", votes_count: 2) 
      q3 = create(:question, user: @user1, correct: false, body: "i have taken up tennis", votes_count: 3) 
      q4 = @question
      Question.by_votes.should == [q4, q3, q2, q1] 
    end
    
    it "returns a sorted array questions by date" do 
      @user1 = create(:user)
      q1 = create(:question, user: @user1, correct: true, body: "im slicing it now", votes_count: 1) 
      q2 = create(:question, user: @user1, correct: false, body: "im hooking the ball", votes_count: 2) 
      q3 = create(:question, user: @user1, correct: false, body: "i have taken up tennis", votes_count: 3) 
      q4 = @question
      Question.by_votes.should == [q4, q3, q2, q1] 
    end
  end
  
    #scope :newest, order: "created_at DESC"
end