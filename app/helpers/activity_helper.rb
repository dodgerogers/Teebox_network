module ActivityHelper
  def build_activity_path(a)
    if a.trackable_type == "Comment"
      object = a.trackable.commentable_type == "Question" ? a.trackable.commentable : a.trackable.commentable.question
    elsif a.trackable_type == "Answer"
      object = a.trackable.question
    end
    a.trackable_type == "User" ? info_path : "#{url_for(object)}##{object.class.name.downcase}_#{object.id}"
  end
end