require "spec_helper"

describe ActivityHelper do
  include Devise::TestHelpers
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @user1.confirm!
    @user2.confirm!
    sign_in @user1
    sign_in @user2
    @number = rand(1..9)
    @question = create(:question, user: @user1, title: "i cannot hit my #{@number} iron", body: "im slicing the ball #{@number} yards")
    @answer = create(:answer, user: @user2, question: @question, body: "try changing your face angle by #{@number} degrees")
    @comment = create(:comment, commentable: @question, user: @user1)
    @activity = create(:activity, trackable: @answer, recipient: @user1, owner: @user2)
  end
  
  describe 'generate_html_activity' do
    context 'with valid activity and instance' do
      it 'returns html for answer' do
        html = helper.generate_activity_html(@activity, @answer)
        html.should include 'gravatar'
        html.should include 'answered'
        html.should include @question.title
      end
      
      it 'returns html for comment' do
        html = helper.generate_activity_html(@activity, @comment)
        html.should include 'gravatar'
        html.should include 'commented on'
        html.should include @question.title
      end
      
      it 'returns html for comment on answer' do
        question = create(:question, user: @user1)
        answer = create(:answer, user: @user2, question: question, body: 'I think you should...')
        comment = create(:comment, commentable_id: answer.id, commentable_type: 'Answer', user: @user1)
        activity = create(:activity, trackable: comment, recipient: @user1, owner: @user2)
        
        html = helper.generate_activity_html(activity, comment)
        html.should include 'gravatar'
        html.should include 'commented on'
        html.should include 'I think you should...'
      end
      
      it 'returns html for user' do
        html = helper.generate_activity_html(@activity, @user1)
        html.should include 'gravatar'
        html.should include 'Need a refresher'
      end
      
      it 'returns html for article' do
        article = create(:article, user: @user1, state: Article::PUBLISHED)
        html = helper.generate_activity_html(@activity, article)
        html.should include 'gravatar'
        html.should include Article::PUBLISHED
      end
      
      it 'returns html for comment on article' do
        article = create(:article, user: @user2, title: 'I think you should...')
        comment = create(:comment, commentable_id: article.id, commentable_type: 'Article', user: @user1)
        activity = create(:activity, trackable: comment, recipient: @user2, owner: @user1)
        
        html = helper.generate_activity_html(activity, comment)
        html.should include 'gravatar'
        html.should include 'commented on'
        html.should include 'I think you should...'
      end
      
      it 'returns explanation string when activity has no trackable object' do
        activity = create(:activity, trackable: nil)
        html = helper.generate_activity_html(activity, @user1)
        html.should include 'Notification has been removed'
      end
    end
    
    context 'with invalid instance type' do
      it 'raises ArgumentError' do
        expect {
          helper.generate_activity_html(@activity, nil)
        }.to raise_error(ArgumentError)
      end
    end
  end  
  
  describe "build_activity_path" do
    it "redirects to activity url for answer" do
      helper.build_activity_path(@activity).should eq(@answer)
    end
  
    it "comment on question redirects to question" do
      @comment = create(:comment, user: @user2, commentable: @question, content: "buy a new set of irons")
      @activity2 = create(:activity, trackable: @comment, recipient: @user1)
      helper.build_activity_path(@activity2).should eq(@comment)
    end
  
    it "comment on answer redirects to answer" do
      @comment = create(:comment, user: @user2, commentable: @answer, content: "buy a new set of irons")
      @activity2 = create(:activity, trackable: @comment, recipient: @user1)
      helper.build_activity_path(@activity2).should eq(@comment)
    end
  
    it "redirects to info_url" do
      @activity2 = create(:activity, trackable: @user1, recipient: @user1)
      helper.build_activity_path(@activity2).should eq info_path
    end
  end
  
  describe 'display_activity_counter' do
    it 'should display counter div when activities present' do
      user = create(:user)
      activity = create(:activity, trackable: @answer, recipient: user, owner: @user2)
      helper.display_activity_counter(user).should include 'new-notifications'
    end
    
    it 'should not display counter when no activities present' do
      user = create(:user)
      user.activities.destroy_all
      helper.display_activity_counter(user).should_not include 'new-notifications'
    end
  end
end