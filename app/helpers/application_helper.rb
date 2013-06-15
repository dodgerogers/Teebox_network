module ApplicationHelper
  
  def clickable_links(text)
    text.gsub(URI.regexp, '<a href="\0">\0</a>')
  end
  
  def youtube_url_html5(url)
    "<iframe class='youtube-player' type='text/html' width='100%' height='400' src='http://www.youtube.com/embed/#{strip_url(url)}' frameborder='0'></iframe>"
  end
  
  def strip_url(url)
    url.gsub!("http://www.youtube.com/watch?v=", "")
  end

  def sublime_video(video, id)
    "<video id='video_#{id}' class='sublime' poster='' width='475px' height='' data-name='#{video}' data-uid='#{video}' preload='none' data-autoresize='fit'>
      <source src='#{video}' /></video>"
  end
    
  def comment_user(user)
    user = User.find_by_id(user)
  end
  
  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase) if user
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=35&d=identicon"
  end
end
