module QuestionHelper
  
  def display_results(questions, options)
    content_tag(:div, id: "params") do
  	  content_tag(:h2, options, class: "zero-margin") +
  	  content_tag(:div, "#{pluralize(questions.total_entries, "Question")} found")
	  end
  end
  
  def social_meta_info(question)
    images ||= social_image(question.videos)
    content_tag(:meta, nil,  name: "twitter:card", content: "summary") +
    content_tag(:meta, nil, name: "twitter:site", content: "@teebox_network") +
    content_tag(:meta, nil, name: "twitter:creator", content: "@teebox_network") +
    content_tag(:meta, nil, name: "twitter:title", content: "#{question.title}") +
    content_tag(:meta, nil, name: "twitter:description", content: "#{truncate(question.body, length: 200)}") +
    content_tag(:meta, nil, name: "twitter:image", content: "#{images}") +
    content_tag(:meta, nil, property: "og:image", content: "#{images}")
  end
end