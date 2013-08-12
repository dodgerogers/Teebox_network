module ActivityHelper
  
  def user_activities(user)
    PublicActivity::Activity.find_all_by_recipient_id(user.id, include: [:owner, :trackable], order: "created_at DESC")
  end
end