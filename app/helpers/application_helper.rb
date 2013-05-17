module ApplicationHelper
  
  def youtube_url_html5(url)
    "<iframe class='youtube-player' type='text/html' width='600' height='' src='http://www.youtube.com/embed/#{strip_url(url)}' frameborder='0'></iframe>"
  end
  
  def strip_url(url)
    url.gsub!("http://www.youtube.com/watch?v=", "")
  end

  def sublime_video(video)
    "<video class='sublime' poster='' width='600px' height='' data-name='#{video}' data-uid='#{video}' preload='none' data-autoresize='fit'>
      <source src='#{video}' /></video>"
  end

  
  def find_video_id(question)
    v = Video.find_by_id(question.video_id)
  end
  
  def question_screenshot(question)
    #change this to a simplified version when screenshots are working using question.video.screenshot
      if question.video_id == 0  then "video_screen.jpg"
      else
        v = Video.find_by_id(question.video_id.to_i)
        if v.nil? || v.screenshot = "" || v.screenshot.nil? then "video_screen.jpg" else v.screenshot 
        end
    end
  end
    
  def comment_user(user)
    user = User.find_by_id(user)
  end
  
  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase) if user
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=35&d=identicon"
  end
end
