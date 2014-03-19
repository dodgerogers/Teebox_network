require "spec_helper"

describe QuestionMailer do
  before(:each) do
    QuestionMailer.any_instance.unstub(:new_question_email)
    ActionMailer::Base.deliveries = []
    ActionMailer::Base.perform_deliveries = true
    @user1 = create(:user, username: "dodgerogers")
    @question = create(:question, user_id: @user1.id)
    QuestionMailer.new_question_email(@question).deliver
  end
  
  after(:each) do
    ActionMailer::Base.deliveries.clear
  end
  
  describe "new_question_email" do
    it "should send the email" do
      ActionMailer::Base.deliveries.count.should eq(1)
    end
    
    it "renders the recipient email" do
      ActionMailer::Base.deliveries.first.to.should eq [@user1.email]
    end
    
    it "sets the correct subject line" do
      ActionMailer::Base.deliveries.first.subject.should eq "New question: #{@question.title}"
    end
    
    it "renders the sender email" do
      ActionMailer::Base.deliveries.first.from.should eq [CONFIG[:email_username]]
    end
  end
end