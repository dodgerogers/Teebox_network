module QuestionHelper
  
  def question_tags(question)
    raw question.tags.map(&:name).map {|n| link_to "#{n.titleize}", tag_path(n), class: "tag" }.join(' ')
  end
  
end