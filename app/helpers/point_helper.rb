module PointHelper
  
  def build_point_path(point)
    obj = point.pointable
    case obj.votable_type
    when "Answer"
      text = obj.votable.try(:body)
    when "Comment"
      text = obj.votable.try(:content)
    else
      text = obj.votable.try(:title)
  	end
  	link_to strip_links_and_trim(text, 60), obj.votable 
  end
end