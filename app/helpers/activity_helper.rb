module ActivityHelper
  
  def number_of_activities(user)
    PublicActivity::Activity.where(read: false, recipient_id: user.id).size
  end
  
  def get_activity_path(activity)
    if activity.trackable_type == "Comment"
      if activity.trackable.commentable_type == "Question"
        "#{url_for(activity.trackable.commentable)}#comment_#{activity.trackable.id}" 
      else
        "#{url_for(activity.trackable.commentable.question)}#comment_#{activity.trackable.id}"
      end
    elsif activity.trackable_type == "Answer"
      "#{url_for(activity.trackable.question)}#answer_#{activity.trackable.id}"
    else
      welcome_path(activity.recipient_id)
    end
  end
end