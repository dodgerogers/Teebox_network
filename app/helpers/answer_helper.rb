module AnswerHelper
  def correct_answer_bg(answer)
    'correct-answer-bg' if answer.correct == true
  end
  
  def correct_answer?(answer)
    answer.correct == true ? 'green-tick' : 'default-tick'
  end
end