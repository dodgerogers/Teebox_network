class Report < ActiveRecord::Base
  
  attr_accessible :questions, :questions_average, :answers_average, 
                  :answers, :users, :users_average, :answers_total, 
                  :questions_total, :users_total
  before_save :set_records
  before_save :set_totals
  #after_create :set_averages
  
  default_scope order('created_at')
  
  def set_records
    self.questions = record_query(Question)
    self.answers = record_query(Answer)
    self.users = record_query(User)
  end
  
  # def set_averages
  #     self.questions_average = average(Report.all.collect(&:questions))
  #     self.answers_average = average(Report.all.collect(&:answers))
  #     self.users_average = average(Report.all.collect(&:users))
  #     self.save!
  #   end
  
  def set_totals
    self.answers_total = Answer.all.size
    self.questions_total = Question.all.size
    self.users_total = User.all.size
  end
  
  private
  
  # def average(objects)
  #     objects.sum.to_f / Report.all.size if Report.all.size > 0
  #   end
  
  def record_query(object)
    object.where("created_at > ?", 1.day.ago).size
  end
end