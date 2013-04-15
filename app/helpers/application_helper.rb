module ApplicationHelper
  
  def youtube_url_html5(url)
    "<iframe class='youtube-player' type='text/html' width='640' height='385' src='http://www.youtube.com/embed/#{strip_url(url)}' frameborder='0'></iframe>"
  end
  
  def strip_url(url)
    url.gsub!("http://www.youtube.com/watch?v=", "")
  end

end
