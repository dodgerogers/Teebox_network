module ApplicationHelper
  
  def youtube_url_html5(url)
    "<iframe class='youtube-player' type='text/html' width='640' height='385' src='http://www.youtube.com/embed/#{strip_url(url)}' frameborder='0'></iframe>"
  end
  
  def strip_url(url)
    url.gsub!("http://www.youtube.com/watch?v=", "")
  end

  def sublime_video(video)
    "<video class='sublime' poster='' width='600px' height=''s data-name='#{video}' data-uid='#{video}' preload='none' data-autoresize='fit'>
      <source src='#{video}' /></video>"
  end
  
  def find_video(question)
    if question.video_id.present?
     v = Video.find(question.video_id)
     raw sublime_video(v.file)
    end
  end
  
  def question_screenshot(question)
    if question.video_id.present?
      v = Video.find(question.video_id)
      v.screenshot
    end
  end
end
