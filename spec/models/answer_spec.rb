require "spec_helper"

describe Answer do  
  before(:each) do
    @user1 = create(:user)
    @answer = create(:answer, correct: true, user_id: @user1.id, body: "i hook the ball with a weak grip")
  end
  
  it { should respond_to(:user_id) }
  it { should respond_to(:question_id) }
  it { should respond_to(:body) }
  it { should respond_to(:correct)}
  it { should respond_to(:votes_count)}
  it { should respond_to(:points)}
  it { should belong_to(:question)}
  it { should belong_to(:user)}
  it { should have_many(:activities)}
  it { should have_many(:comments)}
  it { should have_many(:votes)}
  #it { should validate_uniqueness_of(:correct).scoped_to(:question_id).with_message("correct You can only have 1 correct answer per question (true)") }
  #it { should validate_uniqueness_of(:user_id).scoped_to(:question_id).with_message("user_id Only 1 answer per question per user (1)") }
  

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
  
  describe "length to short" do
    before { @answer.body = ("a" * 9) }
    it { should_not be_valid }
  end
  
  describe "length to long" do
    before { @answer.body = ("a" * 5001) }
    it { should_not be_valid }
  end
  
  describe "Scopes" do
    it "returns an array sorted by votes" do
        @user2 = create(:user)
        @user3 = create(:user)
        @user4 = create(:user)
        a1 = create(:answer, user: @user2, correct: false, body: "your grip is too strong", votes_count: 3) 
        a2 = create(:answer, user: @user3, correct: false, body: "your weight shift is incorrect", votes_count: 2) 
        a3 = create(:answer, user: @user4, correct: false, body: "stop moving your head", votes_count: 1) 
        a4 = @answer
        Answer.by_votes.should == [a1, a2, a3, a4] 
    end
  end
end