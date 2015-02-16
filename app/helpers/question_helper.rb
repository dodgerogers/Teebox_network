module QuestionHelper
  NBSP = '&nbsp;'
  
  def display_results(records, options={})
    capture do
      content_tag(:div, id: "params") do
    	  concat content_tag(:h2, '"' + options + '"', class: "zero-margin")
    	  concat content_tag(:p, "#{pluralize(records.total_entries, records.first.class.to_s)} found")
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