module ApplicationHelper
  
  def demodularize(object)
    object.class.to_s.split("::")[0].singularize
  end
  
  def strip_links_and_trim(object, length=100, tags=[], attrs=[])
    # assign tags and attrs to empty arrays so we can still pass sanitize tags to exclude/include
    truncate(sanitize(object.to_s, tags: tags, attributes: attrs), length: length).gsub("&nbsp;", " ")
  end
  
  def meta_info(object)
    content_tag(:span, class: "meta_info") do
      content_tag(:i, nil, class: "icon-user") +
      (link_to number_to_human(object.user.reputation), object.user, id: "profile-reputation", class: "user_#{object.user.id}") +
      (link_to object.user.username, object.user) +
      content_tag(:i, nil, class: "icon-calendar") +
      ("#{time_ago_in_words(object.created_at)} ago ") +
      (meta_impressions(object) if object.is_a?(Question)) +
		  (render partial: "votes/form", locals: { object: object, vote_path: method("vote_#{demodularize(object).downcase}_path") })
	  end
	end
	
	def meta_impressions(object)
    (content_tag(:i, nil, class: "icon-eye-open")) +
		(pluralize(object.impressions_count, "view")) +
		content_tag(:p, nil)
	end
	
  def profile_link_helper(object)
    content_tag :div, class: "profile" do
      (link_to image_tag(avatar_url(object.user)), object.user) +
      (link_to number_to_human(object.user.reputation), object.user, id: "profile-reputation", class: "user_#{object.user.id}") +
      (link_to object.user.username.titleize, object.user, id: "profile-username") +
      "<br>".html_safe +
      content_tag(:small, "#{time_ago_in_words(object.created_at)} ago")
    end
  end
  
  def social_links(page)
    content_tag :div do
      (link_to raw("<i class='icon-facebook-sign medium facebook'></i> "), "http://facebook.com/sharer.php?u=#{page}", target: "_blank") +
      (link_to raw("<i class='icon-google-plus-sign medium google'></i> "), "https://plus.google.com/share?url=#{page}", target: "_blank") +
      (link_to raw("<i class='icon-twitter medium twitter'></i> "), "https://twitter.com/share?url=#{page}", target: "_blank") +
      (link_to raw("<i class='icon-linkedin-sign medium facebook'></i> "), "https://www.linkedin.com/cws/share?url=#{page}", target: "_blank") +
      (link_to raw("<i class='icon-envelope-alt medium'></i>"), "mailto: ?subject=Question on Teebox&body=#{page}")
    end
  end
  
  def personal_links
    content_tag :span do
      (link_to raw("<i class='icon-twitter twitter'></i> "), "https://twitter.com/AndrewRogers747", target: "_blank") +
    	(link_to raw("<i class='icon-google-plus-sign google'></i> "), "https://plus.google.com/+andyrogers747/", target: "_blank") +
    	(link_to raw("<i class='icon-linkedin facebook'></i> "), "http://www.linkedin.com/profile/view?id=52220364&trk=nav_responsive_tab_profile", target: "_blank") +
    	(link_to raw("<i class='icon-github-alt'></i>"), "https://gist.github.com/dodgerogers", target: "_blank")
  	end
	end
  
  def avatar_url(user, size=35)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase) if user
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=identicon"
  end
  
  def percent_of(a, b)
   x ||= (a == 0 ? -100 : (b == 0 ? 100 : ((a.to_f - b.to_f) / b.to_f) * 100))
  end
end
