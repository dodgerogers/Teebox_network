module QuestionHelper
  def display_results(questions, options)
  	content_tag(:h2, options, class: "zero-margin universe") +
  	content_tag(:div, "#{pluralize(questions.size, "Question")} found")
  end 
end