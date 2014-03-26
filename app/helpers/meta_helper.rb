module MetaHelper
  
  def meta_title(title=nil)
    meta_builder(:title, title) { content_for(:title) + " | " + META['title'] }
  end
  
  def meta_keywords(keywords=nil)
    meta_builder(:keywords, keywords) { [content_for(:keywords), META["keywords"]].join(", ") }
  end
  
  def meta_description(description=nil)
    meta_builder(:description, description) { content_for(:description) + ". " + META['description']  }
  end
  
  def meta_builder(attribute, text)
    content_for(attribute, text) if text
    content_for?(attribute) ? yield : META["#{attribute.to_s}"]
  end
  
  def meta_image(videos)
    video = (videos.any? ? display_xl_screenshot(videos[0]) : asset_path("video_screen.png"))
  end
  
  def social_meta_info(question)
    images ||= meta_image(question.videos)
    content_tag(:meta, nil, name: "twitter:card", content: "summary") +
    content_tag(:meta, nil, name: "twitter:site", content: "@teebox_network") +
    content_tag(:meta, nil, name: "twitter:creator", content: "@teebox_network") +
    content_tag(:meta, nil, name: "twitter:url", content: request.original_url) +
    content_tag(:meta, nil, name: "twitter:domain", content: request.original_url.split("/")[0..2].join("/")) +
    content_tag(:meta, nil, name: "twitter:title", content: "#{truncate(question.title, length: 70)}") +
    content_tag(:meta, nil, name: "twitter:description", content: "#{truncate(question.body, length: 200)}") +
    content_tag(:meta, nil, name: "twitter:image", content: "#{images}") +
    content_tag(:meta, nil, property: "og:image", content: "#{images}")
  end
  
  def social_statistics
    stat ||= Statistics::Social.last
  end
end