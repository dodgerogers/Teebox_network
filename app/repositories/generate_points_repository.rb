class GeneratePointsRepository < BaseRepository
  ERROR_MSG_GENERIC = "GeneratePointsRepo error: %s"
  
  def self.generate(*args)
    args.each do |arg|
      raise ArgumentError, sprintf(ERROR_MSG_GENERIC, "args must be a Hash") unless arg.is_a?(Hash)
      raise ArgumentError, sprintf(ERROR_MSG_GENERIC, "value must be an integer") unless arg[:value].is_a?(Integer)
      
      entry = arg[:entry]
      value = arg[:value]
      
      # Should not know about fetching/updating points, move to point find_and_update method in PointRepo
      Teebox::Pointable.create(entry.user, entry) unless entry.point
      
      point = Point.where(pointable_id: entry.id, pointable_type: entry.class.to_s).first
      point.update_attributes(value: value) if point
    end
  end
end