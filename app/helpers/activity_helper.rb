module ActivityHelper
  
  def number_of_activities(user)
    PublicActivity::Activity.where(read: false, recipient_id: user.id).size
  end
  
  def get_activity_path(a)
    if a.trackable_type == "Comment"
      object = a.trackable.commentable_type == "Question" ? a.trackable.commentable : a.trackable.commentable.question
    elsif a.trackable_type == "Answer"
      object = a.trackable.question
    end
    a.trackable_type == "User" ? info_path : "#{url_for(object)}##{a.trackable_type.downcase}_#{a.trackable.id}"
  end
end