module QuestionHelper
  
  def question_tags(question)
    raw question.tags.map(&:attributes).map {|tag| link_to tag["name"], tagged_path(tag["name"]), class: "tag" }.join(" ")
  end
  
  def tag_class(tag)
    "#{request.protocol}#{request.host_with_port}#{request.fullpath}" == tag_url(tag.name) ? "current_tag" : "tag" 
  end
end