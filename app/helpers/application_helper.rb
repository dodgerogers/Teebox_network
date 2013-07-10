module ApplicationHelper
  
  def profile_link_helper(object)
  	out =  capture  { link_to image_tag(avatar_url(object.user)), object.user }
  	out << capture { link_to number_to_human(object.user.reputation), object.user, id: "profile-reputation" }
  	out << capture { link_to object.user.username.titleize, object.user, id: "profile-username" }
  	out << "<br>".html_safe
  	out << "Posted #{time_ago_in_words(object.created_at)} ago"
  end
  
  #use for remote true links 
  def edit_delete_links(object, options={}) 
		out = capture { link_to "Delete ", object, method: :delete, id: options[:delete_id], class: options[:delete_class], remote: :true } if object
		out << capture { link_to "Edit", options[:path], id: options[:edit_id], class: options[:edit_class], remote: true } if options[:path]
		out if object.user == current_user
	end
  
  def clickable_links(text)
    text.gsub(URI.regexp, '<a href="\0">\0</a>')
  end
  
  def avatar_url(user, size=35)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase) if user
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=identicon"
  end
end
