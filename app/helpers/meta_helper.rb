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
end