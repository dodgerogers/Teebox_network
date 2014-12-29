module CommentHelper
  def display_comments(object)
    klass = demodularize(object).downcase
    div = "#{klass}_#{object.id}_comments"
    count = pluralize(object.comments_count, "comment")
      
    content_tag(:div, id: div) do
		  content_tag(:section, nil) do
	      if object.comments.any?
			    (link_to "View #{count}", '#', class: "toggle-comments", data: { url: polymorphic_url(object), div: div }) +
  			  (render partial: "shared/loading", locals: { message: "comments..." })
  		  end
		  end
	  end
  end
end