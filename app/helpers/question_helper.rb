module QuestionHelper
  
  def display_results(questions, options)
    content_tag(:div, id: "params") do
  	  content_tag(:h2, options, class: "zero-margin") +
  	  content_tag(:div, "#{pluralize(questions.total_entries, "Question")} found")
	  end
  end
end