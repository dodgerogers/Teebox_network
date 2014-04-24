module ActivityHelper
  
  def build_activity_path(activity)
    if activity.trackable_type == "User"
      info_path
    else
      activity.trackable
    end
  end
  
  def build_point_path(point)
    p = point.pointable
    case p.votable_type
    when "Answer"
      text = p.votable.body
    when "Question"
      text = p.votable.title 
    when "Comment"
      text = p.votable.content
  	end
  	link_to truncate(text, length: 60), p.votable 
  end
end