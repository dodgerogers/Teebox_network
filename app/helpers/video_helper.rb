module VideoHelper
  
  def youtube_url_html5(video)
    video_tag([video], class: "sublime", size: "748x374", preload: "none", data: {"youtube-id" => strip_url(video), name: video, uid: video, autoresize: "fit"})
  end
  
  def sublime_video(video)
    video_tag([video.file], id: "video_#{video.id}", class: "sublime", size: "748x374", data: { name: video.file, uid: video.id, autoresize: "fit" }, preload: "none")
  end
  
  def strip_url(url)
    url.gsub!("http://www.youtube.com/watch?v=", "")
  end             
  
  def sublimevideo_rails
    @site_token ||= CONFIG[:sublime_token]
  end
  
  def display_xl_screenshot(video)
    video.screenshot.present? ? video.screenshot : "video_screen.png"
  end
  
  def display_mini_screenshot(video)
    (video.screenshot_url(:mini) if video) || "video_screen_mini.png"
  end
  
  def persist_selected(question, video)
    question.videos.map(&:id).include?(video.id) ? 'selected_video' : ''
  end
end