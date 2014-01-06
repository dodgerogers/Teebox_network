class GenerateReport < Report
  def initialize(report)
    @report = report
    @models = ["question", "answer", "user"]
  end
  
  def create
    @report.class.transaction do
      @models.each do |object|
        @report.send("#{object.pluralize}"+ "=", record_query(object))
        @report.send("#{object.pluralize}_total" + "=", object.classify.constantize.all.size)
      end
    end
  end
  
  private 
  
  def record_query(object)
    object.classify.constantize.where("created_at > ?", 1.day.ago).size
  end
end