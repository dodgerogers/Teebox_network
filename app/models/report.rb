class Report < ActiveRecord::Base
  
  attr_accessible :questions, :questions_average, :answers_average, 
                  :answers, :users, :users_average, :answers_total, 
                  :questions_total, :users_total
  before_save :set_records
  before_save :set_totals
  
  def set_records
    self.class.transaction do
      self.questions = record_query("question")
      self.answers = record_query("answer")
      self.users = record_query("user")
    end
  end
  
  def set_totals
    self.answers_total = Answer.all.size
    self.questions_total = Question.all.size
    self.users_total = User.all.size
  end
  
  private
  
  def record_query(object)
    object.classify.constantize.where("created_at > ?", 1.day.ago).size
  end
end