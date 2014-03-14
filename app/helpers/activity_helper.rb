module ActivityHelper
  
  def build_activity_path(a)
    case a.trackable_type
    when "Comment"
      a.trackable.commentable
    when "Answer"
      a.trackable
    when "User"
      info_path
    end
  end
  
  def build_point_path(point)
    p = point.pointable
    case p.votable_type
    when "Answer"
      text = p.votable.body; path = p.votable 
    when "Question"
      text = p.votable.title; path = p.votable 
    when "Comment"
      text = p.votable.content; path = p.votable.commentable
  	end
    link_to truncate(text, length: 60), path
  end
end