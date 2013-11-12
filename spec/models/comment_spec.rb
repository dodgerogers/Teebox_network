require 'spec_helper'

describe Comment do
  before(:each) do
    @user1 = create(:user, username: "dodgerogers747")
    @user2 = create(:user, username: "randyrogers")
    @question = create(:question, user: @user1, title: "My swing is too short", body: "my flexibility isn't great")
    @comment = create(:comment, commentable_id: @question.id, content: "this is a comment for @randyrogers", user: @user1)
    Comment.any_instance.stub(:display_mentions).and_return(@comment)
  end
  
  subject { @comment }
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:commentable) }
  it { should respond_to(:points) }
  it { should belong_to(:user) }
  it { should belong_to(:commentable) }
  it { should have_many(:activities) }
  it { should have_many(:votes) }
  it { should ensure_length_of(:content).is_at_least(10) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }
  #it { should ensure_length_of(:content).is_at_most(350).with_message("content exceeds 350 characters") }
  
  describe 'content' do
    before { @comment.content = nil }
    it { should_not be_valid }
  end
   
  describe 'short content' do
    before { @comment.content = "comment" }
    it { should_not be_valid }
  end
  
  describe 'long content' do
    before { @comment.content = ('a' * 351) }
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
  
  describe "find_mentions" do
    it "returns array of names" do
      @comment.find_mentions.should eq(["randyrogers"])
    end
  end

  describe "mentions" do
    describe "display_mentions" do
      it "containing valid user" do
        @comment.display_mentions.content.should eq("this is a comment for <a href='/users/#{@user2.id}-#{@user2.username}'>@#{@user2.username}</a>")
      end
    
      it "no valid users" do
        @comment.content = "hey @dodgey this is a comment"
        @comment.display_mentions.content.should eq("hey @dodgey this is a comment")
      end
    end
  end  
end