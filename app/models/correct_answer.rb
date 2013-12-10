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
      update_points([@answer, 12], [@answer.question, 5])
    else
      update_points([@answer], [@answer.question])
    end
  end
   
  def answer_correct?(truth)
    @answer.correct == truth && @answer.user != @answer.question.user
  end
  
  def update_points(*objects)
    objects.each {|obj| obj[0].point.update_attributes(value: obj[1]) }
  end
end