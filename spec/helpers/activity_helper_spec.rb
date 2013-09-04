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
    @question = create(:question, user: @user1, title: "i can't hit my #{@number} iron", body: "im slicing the ball #{@number} yards")
    @answer = create(:answer, user: @user2, question_id: @question.id, body: "try changing your face angle by #{@number} degrees")
    @activity = create(:activity, trackable_id: @answer.id, recipient_id: @user1.id, trackable_type: "Answer")
  end

  subject { @activity }
  
  describe "number_of_activities with welcome notification" do
    it "retrieves size of array" do
      #accounts for activity created when signing up a user
      helper.number_of_activities(@user1).should eq(2)
    end
  end
  
  describe "get_activity_path" do
    it "redirects to activity url" do
      helper.get_activity_path(@activity).should eq("/questions/#{@question.id}-i-can-t-hit-my-#{@number}-iron#answer_#{@answer.id}")
    end
    
    it "redirects to welcome url" do
       @activity2 = create(:activity, trackable_id: @answer.id, recipient_id: @user1.id, trackable_type: "User")
      helper.get_activity_path(@activity2).should eq welcome_path(@activity.recipient_id)
    end
  end
end