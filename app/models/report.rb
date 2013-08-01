class Report < ActiveRecord::Base
  
  attr_accessible :questions, :questions_average, :answers_average, :answers, :users, :users_average
  before_save :set_records
  after_create :set_averages
  
  default_scope order('created_at DESC')
  
  def set_records
    self.questions = record_query(Question)
    self.answers = record_query(Answer)
    self.users = record_query(User)
  end
  
  def set_averages
    self.questions_average = Report.all.collect(&:questions).sum.to_f / Report.all.size if Report.all.size > 0
    self.answers_average = Report.all.collect(&:answers).sum.to_f / Report.all.size if Report.all.size > 0
    self.users_average = Report.all.collect(&:users).sum.to_f / Report.all.size if Report.all.size > 0
    self.save!
  end
  
  private
  
  def record_query(object)
    object.where("created_at > ?", 1.day.ago).size
  end
end