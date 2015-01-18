module QuestionHelper
  NBSP = '&nbsp;'
  
  def display_results(questions, options={})
    capture do
      content_tag(:div, id: "params") do
    	  concat content_tag(:h2, '"' + options + '"', class: "zero-margin")
    	  concat content_tag(:p, "#{pluralize(questions.total_entries, "Question")} found")
  	  end
	  end
  end
  
  def has_videos?(question)
    color = question.videos_count > 0 ? 'green' : nil
    capture do
      concat content_tag(:i, nil, class: "icon-facetime-video #{color}")
      concat NBSP.html_safe
      concat content_tag(:span, question.videos_count)
    end
  end
end