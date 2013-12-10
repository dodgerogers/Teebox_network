module Teebox::Pointable
  def self.create_point(object_user, object, points=0)
    object_user.points.build(value: points, pointable_id: object.id, pointable_type: object.class.name.capitalize).save
  end
end