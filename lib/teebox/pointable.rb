module Teebox::Pointable
  def self.create(user, object, points=0)
    user.points.build(value: points, pointable_id: object.id, pointable_type: object.class.name.capitalize).save
  end
end