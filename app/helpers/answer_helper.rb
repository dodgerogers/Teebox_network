module AnswerHelper
  def correct_answer?(answer)
    answer.correct == true ? 'green-tick' : 'default-tick'
  end
end