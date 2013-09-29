module QuestionHelper
  def display_results(questions, options)
  	content_tag(:h2, options, class: "zero-margin universe") +
  	content_tag(:div, "#{pluralize(questions.total_entries, "Question")} found")
  end 
end