module VideoHelper
  
  def format_name(video, opts={})
    if video.name.present?
      opts[:truncate] ? truncate(video.name, length: 22) : video.name
    else
      video.formatted_filename
    end
  end
  
  def display_video_meta_info(video)
    nbsp = '&nbsp;'.html_safe 
    capture do
      concat content_tag(:i, nbsp, class: 'icon-globe')
      concat (video.location || '--')
      concat nbsp
      concat content_tag(:i, nbsp, class: 'icon-time')
      concat (format_seconds(video.duration) || '--')
      concat "<br>".html_safe
      concat content_tag(:i, nbsp, class: 'icon-calendar')
      concat video.created_at.strftime("%d %b %Y")
    end
  end
  
  def format_seconds(seconds)
    return nil if seconds.to_s.blank?
	  Time.at(seconds.to_i).utc.strftime("%M:%S")
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
    case video.status.try(:downcase)
    when "submitted"
      link_to content_tag(:i, nil, class: "icon-gear green icon-spin"), '#', class: "processing", title: "Processing, refresh to update", rel: "tooltip"
    when "error"
      link_to content_tag(:i, nil, class: "icon-exclamation-sign red"), '#', class: "processing", title: "Converting Failed", rel: "tooltip"
    end
  end
  
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
end