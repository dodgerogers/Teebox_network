module QuestionHelper
  
  def question_tags(question)
    raw question.tags.map(&:attributes).map {|tag| link_to tag["name"], tag_path(tag), class: "tag" }.join(" ")
  end
end