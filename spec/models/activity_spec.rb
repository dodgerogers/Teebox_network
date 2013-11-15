require "spec_helper"

describe Activity do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @number = rand(1..9)
    @question = create(:question, user: @user1, title: "i can't hit my #{@number} iron", body: "im slicing the ball #{@number} yards")
    @answer = create(:answer, user: @user2, question_id: @question.id, body: "try changing your face angle by #{@number} degrees")
    @activity = create(:activity, trackable_id: @answer.id, recipient_id: @user1.id, trackable_type: "Answer")
  end
  
  subject { @activity }
  
  describe "new_activities" do
    it "shows number of new_activities" do
      #accounts for activity created when signing up a user
      Activity.new_activities(@user1).should eq(2)
    end
  end
end