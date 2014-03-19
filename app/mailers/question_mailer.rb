class QuestionMailer < ActionMailer::Base
  default from: CONFIG[:email_username]
  
  def new_question_email(question)
    @question = question
    @email = User.where(username: "dodgerogers")[0].email
    mail(to: @email, subject: "New question: #{@question.title}")
  end
end
