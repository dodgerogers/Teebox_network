require 'spec_helper'

describe Comment do
  before(:each) do
    @comment = FactoryGirl.create(:comment)
  end
  
  subject { @comment }
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:commentable) }
  it { should respond_to(:points)}
  it { should belong_to(:user)}
  it { should belong_to(:commentable)}
  it { should have_many(:activities)}
  it { should have_many(:votes)}
  
  describe 'content' do
     before { @comment.content = nil }
     it { should_not be_valid }
   end
   
   describe 'content' do
      before { @comment.content = "comment" }
      it { should_not be_valid }
    end
    
    describe "obscenity filter" do
      before { @comment.content = "shit" }
      it { should_not be_profane }
    end
   
   describe "user_id" do
     before { @comment.user_id = nil }
      it { should_not be_valid }
    end
    
    describe "commentable id" do
       before { @comment.commentable_id = nil }
        it { should_not be_valid }
      end
    
    describe "commentable type" do
       before { @comment.commentable_type = nil }
        it { should_not be_valid }
      end  
end