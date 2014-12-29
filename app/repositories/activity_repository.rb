class ActivityRepository < BaseRepository
  include ActivityHelper
  
  def initialize(instance)
    @instance = instance
  end
  
  def generate(action, opts={})
    owner, recipient = opts.values_at(:owner, :recipient)
    raise ArgumentError, 'You must provide an instance object' unless @instance
    
    if owner != recipient
      activity = @instance.create_activity(action, owner: owner, recipient: recipient)
      activity.html = ApplicationController.helpers.generate_activity_html(activity, @instance)
      activity.save
    end
  end
end