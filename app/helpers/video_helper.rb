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
  
  def display_screenshot(video, size=:xl)
    if video && video.screenshot.present?
      video.screenshot
    else
      "video_screen_#{size}.png"
    end
  end
  
  def persist_selected(question, video)
    question.videos.map(&:id).include?(video.id) ? 'selected_video' : ''
  end
  
  def video_processed?(video)
    case video.status
    when "Submitted"
      link_to content_tag(:i, nil, class: "icon-gear green icon-spin"), '#', class: "processing", title: "Processing, refresh to update", rel: "tooltip"
    when "ERROR"
      link_to content_tag(:i, nil, class: "icon-exclamation-sign red"), '#', class: "processing", title: "Converting Failed", rel: "tooltip"
    end
  end
end