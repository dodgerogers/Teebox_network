module ActivityHelper
  
  def build_activity_path(activity)
    if activity.trackable_type == "User"
      info_path
    else
      activity.trackable
    end
  end
  
  def build_point_path(point)
    obj = point.pointable
    case obj.votable_type
    when "Answer"
      text = obj.votable.body
    when "Question"
      text = obj.votable.title 
    when "Comment"
      text = obj.votable.content
  	end
  	link_to truncate(strip_tags(text.to_s), length: 60), obj.votable 
  end
end