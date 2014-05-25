class Activity < PublicActivity::Activity

  def self.user_notifications(user)
    where(recipient_id: user.id).includes(:owner, :trackable, :recipient).order("created_at DESC")
  end

  def self.new_activities(user)
    self.where(read: false, recipient_id: user.id).size
  end

  def read_activity
    self.toggle(:read) if self.read == false
  end
end