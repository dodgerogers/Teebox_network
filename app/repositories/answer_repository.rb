class AnswerRepository < BaseRepository

  def self.toggle(answer_params)
    begin
      answer = Answer.find(answer_params[:id])
    rescue
      return nil
    end
    
    if answer
      answer.class.transaction do
        
        answer.toggle_correct(:correct)
        answer.question.toggle_correct(:correct)
        
        if self.check_correctness_and_user?(answer, true)
          PointRepository.generate(
            {entry: answer, value: Answer::CORRECT_ANSWER}, 
            {entry: answer.question, value: Answer::QUESTION_MARKED_AS_CORRECT})
        elsif self.check_correctness_and_user?(answer, false)
          PointRepository.generate(
            {entry: answer, value: Answer::REVERT}, 
            {entry: answer.question, value: Answer::REVERT})
        end
      end
      return answer
    end
  end
  
  def self.check_correctness_and_user?(answer, truth)
    answer.correct == truth && answer.user != answer.question.user
  end
end