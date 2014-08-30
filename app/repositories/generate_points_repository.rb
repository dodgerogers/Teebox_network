class GeneratePointsRepository < BaseRepository
  
  def self.generate(*args)
    args.each do |object|
      raise ArgumentError, "args must be a Hash" unless object.is_a?(Hash)
      raise ArgumentError, "value must be an integer" unless object[:value].is_a?(Integer)
      
      entry = object[:entry]
      value = object[:value]
      
      Teebox::Pointable.create(entry.user, entry) unless entry.point
      
      point = Point.where(pointable_id: entry.id, pointable_type: entry.class.to_s).first
      point.update_attributes(value: value) if point
    end
  end
end