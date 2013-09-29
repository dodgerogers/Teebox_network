module ApplicationHelper
  
  def points_from_correct(question)
    if question.correct == true
      correct = question.answers.find_by_correct(true)
      correct ? (correct.try(:user) == question.user ? "" : "+5") : ""
    end
	end
  
  def profile_link_helper(object)
    content_tag :div, class: "profile" do
      (link_to image_tag(avatar_url(object.user)), object.user) +
      (link_to number_to_human(object.user.reputation), object.user, id: "profile-reputation") +
      (link_to object.user.username.titleize, object.user, id: "profile-username") +
      "<br>".html_safe +
      "Posted #{time_ago_in_words(object.created_at)} ago"
    end
  end
    
  def clickable_links(text)
    text.gsub(URI.regexp, '<a href="\0">\0</a>')
  end
  
  def avatar_url(user, size=35)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase) if user
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=identicon"
  end
  
  def hide_footer
    current_page?(new_user_session_path) || current_page?(new_user_registration_path) || current_page?(new_user_confirmation_path) ? 'hide' : ''
  end
  
  def percent_of(a, b)
   x ||= (a == 0 ? -100 : (b == 0 ? 100 : ((a.to_f - b.to_f) / b.to_f) * 100))
  end
end
