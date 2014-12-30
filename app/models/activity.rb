class Activity < PublicActivity::Activity
  
  attr_accessible :read, :html
  after_commit :notify_recipient, on: :create

  def self.latest_notifications(user)
    where(recipient_id: user.id).order("created_at DESC")
  end

  def self.unread_notifications(user)
    self.where(read: false, recipient_id: user.id).size
  end

  def read_activity
    self.toggle(:read) if self.read == false
  end
end