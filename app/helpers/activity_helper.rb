module ActivityHelper
  
  def number_of_activities(user)
    PublicActivity::Activity.where(read: false, recipient_id: user.id).size
  end
  
  def get_activity_path(activity)
    if activity.trackable_type == "Comment"
      "#{url_for(activity.trackable.commentable)}#comment_#{activity.trackable.id}"
    else
      "#{url_for(activity.trackable.question)}#answer_#{activity.trackable.id}"
    end
  end
end