class ReportRepository < BaseRepository
  ERROR_MSG_GENERIC = "ReportRepository error: %s"
  
  def self.generate(report)
    raise ArgumentError, sprintf(ERROR_MSG_GENERIC, "must supply a valid report object") unless report.is_a?(Report)
    
    models = ["question", "answer", "user"]
    
    if report
      report.class.transaction do
        models.each do |object|
          report.send("#{object.pluralize}"+ "=", self.record_query(object))
          report.send("#{object.pluralize}_total" + "=", object.classify.constantize.all.size)
        end
      end
      report.save!
    end
  end
  
  private 
  
  def self.record_query(object)
    object.classify.constantize.where("created_at > ?", 1.day.ago).size
  end
end