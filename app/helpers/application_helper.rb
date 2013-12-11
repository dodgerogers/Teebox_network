module ApplicationHelper
  
  def points_from_correct(question)
    if question.correct == true
      correct = question.answers.find_by_correct(true)
      correct ? (correct.try(:user) == question.user ? "0" : "+5") : "0"
    end
	end
  
  def profile_link_helper(object)
    content_tag :div, class: "profile" do
      (link_to image_tag(avatar_url(object.user)), object.user) +
      (link_to number_to_human(object.user.reputation), object.user, id: "profile-reputation", class: "user_#{object.user.id}") +
      (link_to object.user.username.titleize, object.user, id: "profile-username") +
      "<br>".html_safe +
      "<small>Posted #{time_ago_in_words(object.created_at)} ago</small>".html_safe
    end
  end
  
  def social_links(page)
    content_tag :div do
      (link_to raw("<i class='icon-facebook-sign large facebook'></i> "), "http://facebook.com/sharer.php?u=#{page}", target: "_blank") +
      (link_to raw("<i class='icon-google-plus-sign large google'></i> "), "https://plus.google.com/share?url=#{page}", target: "_blank") +
      (link_to raw("<i class='icon-twitter large twitter'></i> "), "https://twitter.com/share?url=#{page}", target: "_blank")
    end
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
