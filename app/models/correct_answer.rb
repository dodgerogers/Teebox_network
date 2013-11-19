class CorrectAnswer < Answer
  def initialize(answer)
    @answer = answer
  end
  
  def create
    @answer.class.transaction do
      @answer.question.toggle_correct(:correct)
      add_reputation
    end
    @answer.save!
  end  
  
  def add_reputation
    if answer_correct?(true)
      update_answer_user_rep(20, :+)
      update_question_user_rep(5, :+)
    elsif answer_correct?(false)
      update_answer_user_rep(20, :-)
      update_question_user_rep(5, :-)
    end
  end
   
  def answer_correct?(truth)
    @answer.correct == truth && @answer.user != @answer.question.user
  end
  
  def update_answer_user_rep(points, operator)
    @answer.user.update_attributes(reputation: (@answer.user.reputation.send(operator, points)))
  end
  
  def update_question_user_rep(points, operator)
    @answer.question.user.update_attributes(reputation: (@answer.question.user.reputation.send(operator, points)))
  end
end