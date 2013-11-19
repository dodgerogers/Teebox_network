class GenerateReport < Report
  def initialize(report)
    @report = report
  end
  
  def create
    @report.class.transaction do
      set_records
      set_totals
    end
    @report.save!
  end
  
  private 
  
  def set_records
    @report.class.transaction do
      @report.questions = record_query("question")
      @report.answers = record_query("answer")
      @report.users = record_query("user")
    end
  end
  
  def set_totals
    @report.class.transaction do
      @report.answers_total = Answer.all.size
      @report.questions_total = Question.all.size
      @report.users_total = User.all.size
    end  
  end
  
  def record_query(object)
    object.classify.constantize.where("created_at > ?", 1.day.ago).size
  end
end