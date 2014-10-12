class PointRepository < BaseRepository
  ERROR_MSG_GENERIC = "GeneratePointsRepo error: %s"
  
  def self.generate(*arguments)
    arguments.each do |arg|
      self.find_and_update(arg)
    end
  end
  
  def self.find_and_update(attributes)
    raise ArgumentError, sprintf(ERROR_MSG_GENERIC, "args must be a Hash") unless attributes.is_a?(Hash)
    raise ArgumentError, sprintf(ERROR_MSG_GENERIC, "value must be an integer") unless attributes[:value].is_a?(Integer)
    
    entry = attributes[:entry]
    value = attributes[:value]
    
    Teebox::Pointable.create(entry.user, entry) unless entry.point
    
    point = Point.where(pointable_id: entry.id, pointable_type: entry.class.to_s).first 
    point.update_attributes(value: value) if point
  end
end