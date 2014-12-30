module ActivityHelper
  include Rails.application.routes.url_helpers
  
  NOT_IMPLEMENTED_MSG = "Not implemented :notification_message_format for: %s"
  
  def generate_activity_html(activity, instance)
    if activity.trackable
      link, text = activity_text(instance).values_at(:link, :text)
      user = activity.owner || activity.recipient
      attrs = { user: user, link: link, text: text }
    
      capture do 
        concat activity_header(user)
        concat activity_message(activity, attrs)
      end
    else
      content_tag(:td) { 'Notification has been removed' }
    end
  end
  
  def build_activity_path(activity)
    activity.trackable_type == 'User' ? info_path : activity.trackable
  end
  
  private
  
  def activity_header(user)
    content_tag(:td) do
      content_tag(:div, class: "gravatar") do
  			link_to image_tag(avatar_url(user, 40)), user_url(user), id: "gravatar"
  		end
		end
	end 
  
  def activity_message(activity, opts={})
    user, link, text = opts.values_at(:user, :link, :text)
    capture do
      content_tag(:td) do
        content_tag(:div, class: 'message') do
          concat link_to user.try(:username), user_url(user)
          concat " #{text} ".html_safe
          concat link_to link, read_activity_url(activity)
          concat '<br>'.html_safe
          concat activity_timestamp(activity)
        end
      end
    end   
  end

  def activity_timestamp(activity)
    content_tag(:small) do
      concat content_tag(:i, nil,  class: "icon-calendar")
      concat " " + time_ago_in_words(activity.created_at) + " ago".html_safe
    end
  end
  
  def activity_text(instance)
    instance.try(:notification_message_format) || (raise ArgumentError, sprintf(NOT_IMPLEMENTED_MSG, instance.class))
  end
end