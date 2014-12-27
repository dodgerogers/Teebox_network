module ApplicationHelper
  
  FACEBOOK_SHARE_URL = "http://facebook.com/sharer.php?u="
  GOOGLE_SHARE_URL = "https://plus.google.com/share?url="
  TWITTER_SHARE_URL = "https://twitter.com/share?url="
  LINKEDIN_SHARE_URL = "https://www.linkedin.com/cws/share?url="
  
  OWNER_TWITTER_PAGE = "https://twitter.com/AndrewRogers747"
  OWNER_GOOGLE_PAGE = "https://plus.google.com/+andyrogers747/"
  OWNER_LINKEDIN_PAGE = "http://www.linkedin.com/profile/view?id=52220364&trk=nav_responsive_tab_profile"
  OWNER_GIST_PAGE = "https://gist.github.com/dodgerogers"
  
  def application_banner(background_image='forest-banner')
    content_for :banner do
      content_tag(:div, class: background_image) do
    	  content_tag(:div, id: "minimal-padding", class: "hero-unit mobile home") do
          content_tag(:div, class: "container center") do
            yield if block_given?
          end
        end
      end
    end
  end
  
  def demodularize(object)
    object.class.to_s.split("::")[0].singularize
  end
  
  def strip_links_and_trim(object, length=100, tags=[], attrs=[])
    truncate(sanitize(object.to_s, tags: tags, attributes: attrs), length: length).gsub("&nbsp;", " ")
  end
	
  def profile_link_helper(object)
    capture do
      content_tag :div, class: "profile" do
        concat link_to image_tag(avatar_url(object.user)), object.user
        concat link_to number_to_human(object.user.reputation), object.user, id: "profile-reputation", class: "user_#{object.user.id}"
        concat link_to object.user.username.titleize, object.user, id: "profile-username"
        concat "<br>".html_safe
        concat content_tag(:small, "#{time_ago_in_words(object.created_at)} ago")
      end
    end
  end
  
  def social_links(page)
    capture do
      content_tag :div do
        concat link_to raw("<i class='icon-facebook-sign medium facebook'></i> "), "#{FACEBOOK_SHARE_URL}#{page}", target: "_blank"
        concat link_to raw("<i class='icon-google-plus-sign medium google'></i> "), "#{GOOGLE_SHARE_URL}#{page}", target: "_blank"
        concat link_to raw("<i class='icon-twitter medium twitter'></i> "), "#{TWITTER_SHARE_URL}#{page}", target: "_blank"
        concat link_to raw("<i class='icon-linkedin-sign medium facebook'></i> "), "#{LINKEDIN_SHARE_URL}#{page}", target: "_blank"
        concat link_to raw("<i class='icon-envelope-alt medium'></i>"), "mailto: ?subject=Question on Teebox&body=#{page}"
      end
    end
  end
  
  def personal_links
    capture do
      content_tag :span do
        concat link_to raw("<i class='icon-twitter twitter'></i> "), OWNER_TWITTER_PAGE, target: "_blank"
      	concat link_to raw("<i class='icon-google-plus-sign google'></i> "), OWNER_GOOGLE_PAGE, target: "_blank"
      	concat link_to raw("<i class='icon-linkedin facebook'></i> "), OWNER_LINKEDIN_PAGE, target: "_blank"
      	concat link_to raw("<i class='icon-github-alt'></i>"), OWNER_GIST_PAGE, target: "_blank"
    	end
  	end
	end
  
  def avatar_url(user, size=35)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase) if user
    return "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=identicon"
  end
  
  def percent_of(a, b)
   x ||= (a == 0 ? -100 : (b == 0 ? 100 : ((a.to_f - b.to_f) / b.to_f) * 100))
  end
  
  def meta_info(object, &block)  
    capture do
      content_tag(:ul, class: "meta_info") do
        content_tag(:small) do
          concat user_metadata(object)
          concat created_at_metadata(object)
          concat question_metadata(object)
          concat render_votes_form(object)
          concat answer_metadata(object)
          
          if block_given?
            content = capture(&block)
      	    concat custom_metadata(content)
          end
    	  end
  	  end
	  end
	end
  
  private
  
  def user_metadata(object)
    content_tag(:li) do
      (link_to "#{object.user.username} ", object.user) +
      (link_to number_to_human(object.user.reputation), object.user, id: "profile-reputation", class: "user_#{object.user.id}")
    end
  end
  
  def created_at_metadata(object)
    content_tag(:li) do
      content_tag(:i, nil, class: "icon-calendar") +
      (" #{time_ago_in_words(object.created_at)} ago")
    end
  end
  
  def question_metadata(object)
    if object.is_a?(Question)
      content_tag(:li) do
         meta_impressions(object)
       end
    end
  end
  
  def render_votes_form(object)
    content_tag(:li) do
	    (render partial: "votes/form", locals: { object: object })
    end
  end
  
  def answer_metadata(object)
    if object.is_a?(Answer)
      content_tag(:li, class: correct_answer?(object)) do
         content_tag(:div, id: "correct_answer_#{object.id}") do
				  if object.question.user == current_user
					  link_to content_tag(:i, nil, class: "icon-ok-sign sm"), correct_answer_path(object), class: "correct_#{object.id} sm", remote: true, method: :put, title: "Most helpful? Mark it as correct"
				  else
					  content_tag(:div, class: "correct_answer_#{object.id}") { content_tag(:i, nil, class: "icon-ok-sign sm") }
				  end
			  end
		  end
	  end
  end
    
	def meta_impressions(object)
    (content_tag(:i, nil, class: "icon-eye-open")) + " #{object.impressions_count}"
	end
	
	def custom_metadata(content)
    if content.present?
      content_tag(:span) do
        content_tag(:li) { content.html_safe }
      end
    end
  end
end
