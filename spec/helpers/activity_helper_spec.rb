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
    @answer = create(:answer, user: @user2, question_id: @question.id, body: "try changing your face angle by #{@number} degrees")
    @comment = create(:comment, commentable_id: @question.id, user_id: @user1.id)
    @activity = create(:activity, trackable_id: @answer.id, recipient_id: @user1.id, trackable_type: "Answer")
    @vote = create(:vote, user: @user1, votable_id: @answer.id)
    @point = create(:point, pointable_id: @vote.id, user_id: @user2.id)
  end

  subject { @activity }
  
  describe "build_activity_path" do
    it "redirects to activity url for answer" do
      helper.build_activity_path(@activity).should eq(@answer) ##answer_#{@answer.id}"
    end
    
    it "comment on question redirects to question" do
      @comment = create(:comment, user: @user2, commentable_id: @question.id, content: "buy a new set of irons")
      @activity2 = create(:activity, trackable_id: @comment.id, recipient_id: @user1.id, trackable_type: "Comment")
      helper.build_activity_path(@activity2).should eq(@comment) ##comment_#{@comment.id}
    end
    
    it "comment on answer redirects to answer" do
      @comment = create(:comment, user: @user2, commentable_id: @answer.id, commentable_type: "Answer", content: "buy a new set of irons")
      @activity2 = create(:activity, trackable_id: @comment.id, recipient_id: @user1.id, trackable_type: "Comment")
      helper.build_activity_path(@activity2).should eq(@comment) ##comment_#{@comment.id}
    end
    
    it "redirects to info_url" do
       @activity2 = create(:activity, trackable_id: @answer.id, recipient_id: @user1.id, trackable_type: "User")
      helper.build_activity_path(@activity2).should eq info_path
    end
  end
  
  describe "build_point_path" do
    it "returns path to question from answer" do
      helper.build_point_path(@point).should eq "<a href=\"/answers/#{@answer.id}-#{@answer.question.title.parameterize}\">try changing your face angle by #{@number} degrees</a>"
    end
    
    it "returns question path" do
      @vote1 = create(:vote, user: @user2, votable_id: @question.id, votable_type: "Question")
      @point2 = create(:point, pointable_id: @vote1.id, user_id: @user2.id)
      helper.build_point_path(@point2).should eq "<a href=\"/questions/#{@question.id}-#{@question.title.parameterize}\">#{@question.title}</a>"
    end
    
    it "returns question path from comment" do
      @vote2 = create(:vote, user: @user2, votable_id: @comment.id, votable_type: "Comment")
      @point3 = create(:point, pointable_id: @vote2.id, user_id: @user2.id)
      helper.build_point_path(@point3).should eq "<a href=\"/comments/#{@comment.id}\">#{@comment.content}</a>"
    end
  end
end