class PublicActivity::Activity
  # Reopening the class to add the after_create hook
  after_commit :notify_recipient, on: :create
  
  def notify_recipient
    # If notifications is set to true send mail
    # also don't want to send en email for the welcome notification
    if self.recipient.notifications == "1" && self.trackable_type != "User"
      NotificationMailer.delay.activity_email(self)
    end
  end
end