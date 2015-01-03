module QuestionHelper
  
  def display_results(questions, options={})
    capture do
      content_tag(:div, id: "params") do
    	  concat content_tag(:h2, options, class: "zero-margin")
    	  concat content_tag(:div, "#{pluralize(questions.total_entries, "Question")} found")
  	  end
	  end
  end
end