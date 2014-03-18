require 'spec_helper'
include TagHelper
include VideoHelper

describe Question do
  before(:each) do
    @question = create(:question)
    @video = create(:video)
    @question.videos << @video
  end
  
  subject {@question}
  
  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:youtube_url) }
  it { should respond_to(:user_id) }
  it { should respond_to(:votes_count)}
  it { should respond_to(:answers_count)}
  it { should respond_to(:impressions_count)}
  it { should respond_to(:correct)}
  it { should belong_to(:user)}
  it { should have_many(:comments)}
  it { should have_many(:votes)}
  it { should have_many(:answers)}
  it { should have_many(:tags).through(:taggings)}
  it { should have_many(:taggings)}
  it { should have_many(:videos).through(:playlists)}
  it { should have_many(:playlists)}
  it { should have_many(:impressions)}
  it { should have_one(:point) }
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:body)}
  it { should validate_presence_of(:user_id)}
  
  describe "exceed tag_limit" do
    before { subject.tags << tag_list }
    it { should_not be_valid }
  end
  
  describe "exceed video_limit" do
    before { subject.videos << video_list }
    it { should_not be_valid }
  end
  
  describe "video_list" do
    it "video_list setter" do
      subject.video_list.should eq "#{@video.id}"
    end
    
    it "video_list getter" do
      subject.videos.should eq [@video]
    end
  end
  
   describe "long title" do
     before { subject.title = ("a" * 91) }
      it { should_not be_valid }
   end
   
   describe "short title" do
      before { subject.title = ("a" * 9) }
       it { should_not be_valid }
    end
    
    describe "obscenity filter title" do
      before { subject.title = "shit" }
      it { should_not be_profane }
    end
    
    describe "validates body" do
      before { subject.body = "fuck" }
      it { should_not be_profane }
    end
    
    describe "tagged_with " do
      it "finds a tag by name" do
        @tag = create(:tag, name: "shank")
        subject.tags << @tag
        Question.tagged_with(@tag.name).should eq [subject]
      end
    end
    
    describe "text_search" do
      it "returns all when search nil" do
        Question.text_search("").should eq [subject]
      end
    end

    #move Questions to helper
    describe "Scopes" do
    it "returns unanswered questions" do 
      @user1 = create(:user)
      q1 = create(:question, user: @user1, correct: true, body: "im slicing it now") 
      q2 = create(:question, user: @user1, correct: false, body: "im hooking the ball") 
      q3 = create(:question, user: @user1, correct: false, body: "i have taken up tennis") 
      q4 = subject
      Question.unanswered.should == [q4, q2, q3] 
    end
    
    it "returns questions by votes" do 
      @user1 = create(:user)
      q1 = create(:question, user: @user1, correct: true, body: "im slicing it now", votes_count: 1) 
      q2 = create(:question, user: @user1, correct: false, body: "im hooking the ball", votes_count: 2) 
      q3 = create(:question, user: @user1, correct: false, body: "i have taken up tennis", votes_count: 3) 
      q4 = subject
      Question.popular.should == [q4, q3, q2, q1] 
    end
    
    it "newest returns questions by date" do 
      @user1 = create(:user)
      q1 = create(:question, user: @user1, correct: true, body: "im slicing it now", votes_count: 1) 
      q2 = create(:question, user: @user1, correct: false, body: "im hooking the ball", votes_count: 2) 
      q3 = create(:question, user: @user1, correct: false, body: "i have taken up tennis", votes_count: 3) 
      q4 = subject
      Question.newest.should == [q3, q2, q1, q4] 
    end
  end
end