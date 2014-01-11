module TagHelper
  def tag_class(tag)
    current_page?(tagged_url(tag.name)) ? "current_tag" : "tag" 
  end
  
  def tab_class(url)
    current_page?(url) ? "submit" : "asphalt" 
  end
end