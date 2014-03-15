module ActivityHelper
  
  def build_activity_path(activity)
    case activity.trackable_type
    when "Comment"
      activity.trackable.commentable
    when "Answer"
      activity.trackable
    when "User"
      info_path
    end
  end
  
  def build_point_path(point)
    p = point.pointable
    case p.votable_type
    when "Answer"
      link_to truncate(p.votable.body, length: 60), p.votable 
    when "Question"
      link_to truncate(p.votable.title, length: 60), p.votable 
    when "Comment"
      link_to truncate(p.votable.content, length: 60), p.votable.commentable
  	end
  end
end